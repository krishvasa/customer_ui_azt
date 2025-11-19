#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int row;
    int col;
} Point;

int find_shortest_path(int R, int C, char grid[R][C]) {
    Point queue[R * C];
    int front = 0;
    int rear = 0;

    Point start_pos;
    int distance[R][C];

    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            distance[i][j] = -1;
            if (grid[i][j] == 'S') {
                start_pos.row = i;
                start_pos.col = j;
            }
        }
    }

    distance[start_pos.row][start_pos.col] = 0;
    queue[rear++] = start_pos;

    int row_moves[] = {-1, 0, 1, 0};
    int col_moves[] = {0, 1, 0, -1};

    while (front != rear) {
        Point current = queue[front++];

        if (grid[current.row][current.col] == 'T') {
            return distance[current.row][current.col];
        }

        for (int i = 0; i < 4; i++) {
            int next_row = current.row + row_moves[i];
            int next_col = current.col + col_moves[i];

            if (next_row >= 0 && next_row < R &&
                next_col >= 0 && next_col < C &&
                grid[next_row][next_col] != 'X' &&
                distance[next_row][next_col] == -1) {
                
                distance[next_row][next_col] = distance[current.row][current.col] + 1;
                
                Point neighbor = {next_row, next_col};
                queue[rear++] = neighbor;
            }
        }
    }

    return -1;
}

int main() {
    int R, C;
    scanf("%d %d", &R, &C);

    char grid[R][C];

    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            scanf(" %c", &grid[i][j]);
        }
    }

    int result = find_shortest_path(R, C, grid);
    printf("%d\n", result);

    return 0;
}