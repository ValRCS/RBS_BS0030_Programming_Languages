const scores = [72, 91, 84, 65, 88];

let total = 0;
let highCount = 0;

for (const score of scores) {
  total += score;
  if (score >= 80) {
    highCount += 1;
  }
}

const average = total / scores.length;
console.log(`average = ${average}`);
console.log(`scores >= 80 = ${highCount}`);
