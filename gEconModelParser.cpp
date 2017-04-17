
// #include "parser/model_parse.h"
#include <model_parse.h>
#include <iostream>

int main(int argc, char **argv) {

  char* filename;
  if (argc >= 1) {
    filename = argv[1];
  }

  std::cout << "Given filename: " << filename << std::endl;

  model_parse(filename);

  return 0;

}
