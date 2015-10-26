#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
        FILE* file = fopen("marisa.obj", "rb");
        size_t linesz = 0;
        char* line = NULL;
        int size = getline(&line, &linesz, file);
        printf("%d\t%d\t%s\n", size, linesz, line);
        free(line);
        fclose(file);
}
