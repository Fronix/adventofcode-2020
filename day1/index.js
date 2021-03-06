const inputs = require('../inputReader.js');
const input = inputs(__dirname, './input.txt')

const part1 = input => {
  const data = input.split('\n')
    .map(str => parseInt(str))
    .sort((a, b) => b - a);

  for (let i = 0; i < data.length; i++) {
    const diff = 2020 - data[i];
    const diffIndex = data.indexOf(diff, i + 1);
    if (diffIndex !== -1) {
      return data[i] * diff;
    }
  }

  return null;
}

const part2 = input => {
  const data = input.split('\n')
    .map(str => parseInt(str))
    .sort((a, b) => b - a);

  for (let i = 0; i < data.length - 1; i++) {
    for (let j = i + 1; j < data.length; j++) {
      const diff = 2020 - data[i] - data[j]
      const diffIndex = data.indexOf(diff, i + 1);
      if (diffIndex !== -1) {
        return data[i] * data[j] * diff;
      }
    }
  }
  return null;
}

console.log('Part one: ', part1(input))
console.log('Part two: ', part2(input))