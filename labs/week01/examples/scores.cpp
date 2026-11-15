#include <iostream>
#include <vector>

int main() {
    std::vector<int> scores{72, 91, 84, 65, 88};
    int total = 0;
    int high_count = 0;

    for (int score : scores) {
        total += score;
        if (score >= 80) ++high_count;
    }

    double average = static_cast<double>(total) / scores.size();
    std::cout << "average = " << average << '\n';
    std::cout << "scores >= 80 = " << high_count << '\n';
}
