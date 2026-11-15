scores = [72, 91, 84, 65, 88]

total = 0
high_count = 0

for score in scores:
    total += score
    if score >= 80:
        high_count += 1

average = total / len(scores)
print(f"average = {average}")
print(f"scores >= 80 = {high_count}")
