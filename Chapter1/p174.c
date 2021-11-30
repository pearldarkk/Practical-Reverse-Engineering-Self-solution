#include <stdio.h>
#include <stdlib.h>

struct data {
    int x;
    int y;
    int z;
} data;

struct data func(struct data obj) {
    ++obj.x;
    obj.y = 5;
    return obj;
}

int main() {
    struct data dat;
    dat.x = 2;
    func(dat);

    return 0;
}

