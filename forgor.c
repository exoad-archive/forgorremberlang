#include <stdio.h>

#include <memory.h>

#include <stdlib.h>

#include <stdarg.h>

#define then
#define QUEUE_SIZE 200
#define EXPAND_CHUNK 20

typedef unsigned char byte_t;

typedef struct {
  char * data;
  int elem, len, size;
}
buf_t;

typedef struct {
  int x, y;
}
vect_t;

typedef struct {
  byte_t data[QUEUE_SIZE];
  int start, len;
  vect_t pos;
}
queue_t;

typedef struct _ip ip_t;
struct _ip {
  vect_t pos, dir;
  queue_t * q;
  byte_t reg;
  ip_t * next;
};

buf_t * lines = NULL, * queues = NULL;
ip_t * last, * current = NULL;
enum {
  RUN,
  SKIP,
  EAT
}
skip;

void error(char * fmt, ...) {
  va_list args;
  buf_t * line;
  va_start(args, fmt);
  fputs("Error: ", stderr);
  vfprintf(stderr, fmt, args);
  fputc('\n', stderr);
  va_end(args);
  /* free all memory. if it crashes somehow, remove this section.
     the operating system should free my memory without my help.  */
  if (queues) {
    if (queues -> data)
      free(queues -> data);
    free(queues);
  }
  if (lines) {
    if (lines -> data) {
      for (line = (buf_t * ) lines -> data; line < (buf_t * )(lines -> data + lines -> len); line++) {
        if (line) {
          if (line -> data)
            free(line -> data);
          free(line);
        }
      }
      free(lines -> data);
    }
    free(lines);
  }
  if (current) {
    last -> next = NULL;
    while (current) {
      last = current;
      current = current -> next;
      free(last);
    }
  }
  exit(1);
}

buf_t * buf_new(int elem, buf_t * where) {
  buf_t * buf;

  if (where == NULL) then buf = (buf_t * ) malloc(sizeof(buf_t));
  else buf = where;
  if (buf == NULL)
    error("Memory allocation error on new_buf()");
  buf -> data = NULL;
  buf -> elem = elem;
  buf -> len = buf -> size = 0;
  return buf;
}

int buf_empty(buf_t * buf) {
  if (buf == NULL)
    return 1;
  if (buf -> len == 0)
    return 1;
  return 0;
}

void buf_expand(buf_t * buf, void * src) {
  void * mem;

  if (buf == NULL)
    return;
  if (buf -> len == buf -> size) {
    buf -> size += buf -> elem * EXPAND_CHUNK;
    mem = realloc(buf -> data, buf -> size);
    if (mem == NULL)
      error("Memory allocation error on buf_expand()");
    buf -> data = mem;
  }
  if (src == NULL) then memset(buf -> data + buf -> len, 0, buf -> elem);
  else memcpy(buf -> data + buf -> len, src, buf -> elem);
  buf -> len += buf -> elem;
}

void * buf_last(buf_t * buf) {
  if (buf == NULL)
    return NULL;
  if (buf -> len == 0)
    return NULL;
  return buf -> data + buf -> len - buf -> elem;
}

void * buf_get(buf_t * buf, int index) {
  if (buf == NULL)
    return NULL;
  if (index < 0)
    return NULL;
  if (index >= buf -> len / buf -> elem)
    return NULL;
  return buf -> data + index * buf -> elem;
}

void read_file(FILE * file) {
  char c;
  buf_t * line;
  queue_t * queue;
  int x, y;

  lines = buf_new(sizeof(buf_t), NULL);
  queues = buf_new(sizeof(queue_t), NULL);
  x = y = 0;
  while ((c = getc(file)) != EOF) {
    if (c == '\n') {
      buf_expand(lines, NULL);
      line = (buf_t * ) buf_last(lines);
      buf_new(1, line);
      x = 0;
      y++;
    } else {
      if (buf_empty(lines)) {
        buf_expand(lines, NULL);
        line = (buf_t * ) buf_last(lines);
        buf_new(1, line);
      }
      if (c == 'Q') {
        buf_expand(queues, NULL);
        queue = buf_last(queues);
        memset(queue -> data, 0, QUEUE_SIZE);
        queue -> start = queue -> len = 0;
        queue -> pos.x = x;
        queue -> pos.y = y;
      }
      buf_expand(line, & c);
      x++;
    }
  }
}

char get_at(int x, int y) {
  buf_t * line;
  char * where;

  line = (buf_t * ) buf_get(lines, y);
  if (line == NULL)
    return ' ';
  where = (char * ) buf_get(line, x);
  if (where == NULL)
    return ' ';
  return *where;
}

byte_t pop(queue_t * q) {
  byte_t res;

  if (q == NULL)
    error("You forgot to set a queue!");
  if (q -> len == 0)
    return 0;
  res = q -> data[q -> start];
  q -> start = (q -> start + 1) % QUEUE_SIZE;
  q -> len--;
  return res;
}

void push(queue_t * q, byte_t data) {
  if (q == NULL)
    error("You forgot to set a queue!");
  if (q -> len == QUEUE_SIZE)
    error("Tried to push too much into the queue");
  q -> data[(q -> start + q -> len++) % QUEUE_SIZE] = data;
}

void inc_dir(vect_t * dir) {
  if (dir -> x == dir -> y)
    dir -> x = 0;
  else if (dir -> x == 0) then dir -> x -= dir -> y;
  else dir -> y += dir -> x;
}

void split_ip(void) {
  ip_t * temp;
  vect_t dir;
  int i;

  dir.x = current -> dir.x;
  dir.y = current -> dir.y;
  for (i = 0; i < 7; i++) {
    inc_dir( & dir);
    if (get_at(current -> pos.x + dir.x, current -> pos.y + dir.y) != ' ') {
      temp = (ip_t * ) malloc(sizeof(ip_t));
      if (temp == NULL)
        error("Buffer Memory Location returned NULL");
      temp -> q = current -> q;
      temp -> reg = current -> reg;
      temp -> pos.x = current -> pos.x + dir.x;
      temp -> pos.y = current -> pos.y + dir.y;
      temp -> dir.x = dir.x;
      temp -> dir.y = dir.y;
      temp -> next = current;
      last -> next = temp;
      last = temp;
    }
  }
}

void parse(char cmd) {
  queue_t * q;

  if ('0' <= cmd && cmd <= '9') {
    push(current -> q, (byte_t)(cmd - '0'));
    return;
  }
  switch (cmd) {
  case 'Q':
    /* set the queue */
    if (current -> q) {
      if (current -> q -> pos.x == current -> pos.x &&
        current -> q -> pos.y == current -> pos.y) {
        break; /* we are on the same queue */
      }
    }
    for (q = (queue_t * ) queues -> data; q < (queue_t * )(queues -> data + queues -> len); q++) {
      if (q -> pos.x == current -> pos.x && q -> pos.y == current -> pos.y) {
        if (current -> q)
          push(q, current -> reg);
        current -> q = q;
      }
    }
    break;

  case ':':
    split_ip();
    break;
  case 'i':
    push(current -> q, (byte_t) getchar());
    break;
  case 'o':
    putchar((int)(signed char) pop(current -> q));
    break;
  case 'l':
    current -> reg = pop(current -> q);
    break;
  case 's':
    push(current -> q, current -> reg);
    break;
  case '+':
    push(current -> q, current -> reg + pop(current -> q));
    break;
  case '-':
    push(current -> q, current -> reg - pop(current -> q));
    break;
  case '*':
    push(current -> q, current -> reg * pop(current -> q));
    break;
  case '/':
    push(current -> q, current -> reg / pop(current -> q));
    break;
  case '%':
    push(current -> q, current -> reg % pop(current -> q));
    break;
  case '!':
    push(current -> q, !pop(current -> q));
    break;
  case '#':
    skip = SKIP;
    break;
  case '$':
    skip = EAT;
    break;
  case '@':
    break;
  }
}

int change_dir(ip_t * ip) {
  vect_t dir;
  byte_t mask[8] = {
    0
  };
  int i, count = 0;

  dir.x = -ip -> dir.x;
  dir.y = -ip -> dir.y;
  inc_dir( & dir);
  for (i = 1; i < 8; i++) {
    if (get_at(ip -> pos.x + dir.x, ip -> pos.y + dir.y) != ' ') {
      mask[i] = 1;
      count++;
    }
    inc_dir( & dir);
  }
  if (count == 0)
    return 0;
  if (count > 1)
    count = pop(ip -> q) % count + 1;
  i = 0;
  while (count > 0) {
    inc_dir( & dir);
    i++;
    if (mask[i]) count--;
  }

  ip -> dir.x = dir.x;
  ip -> dir.y = dir.y;
  return 1;
}

void run(void) {
  current = (ip_t * ) malloc(sizeof(ip_t));
  if (current == NULL)
    error("Memory allocation error while preparing to run");
  last = current -> next = current;
  current -> pos.x = current -> pos.y = 0;
  current -> dir.x = current -> dir.y = 1;
  current -> q = NULL;
  current -> reg = 0;
  skip = RUN;
  while (current != NULL) {
    /* while there are still ips */
    if (skip == EAT)
      if (get_at(current -> pos.x, current -> pos.y) != '$')
        skip = RUN;
    if (skip == RUN)
      parse(get_at(current -> pos.x, current -> pos.y));
    if (skip == SKIP)
      skip = RUN;
    if (change_dir(current)) {
      current -> pos.x += current -> dir.x;
      current -> pos.y += current -> dir.y;
      last = current;
      current = current -> next;
    } else {
      if (last == current) {
        free(current);
        current = NULL;
      } else {
        last -> next = current -> next;
        free(current);
        current = last -> next;
      }
    }
  }
}

int main(int argc, char ** argv) {
  FILE * file;

  if (argc != 2)
    error("Missing filename");
  file = fopen(argv[1], "r");
  if (file == NULL)
    error("Cannot open %s for reading", argv[1]);
  read_file(file);
  run();
  return 0;
}
