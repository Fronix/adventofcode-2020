const inputs = require('./inputs');

const validPasswordsPart1 = () => {
  let validPasswords = 0;

  for (const input of inputs) {
    if (typeof input === 'string') {
      const range = input.match(/(\d+-\d+)/g)[0].split('-');
      const minNumOcc = parseInt(range[0], 10);
      const maxNumOcc = parseInt(range[1], 10);
      const allowedChar = input.match(/(\w:)/g)[0].substr(0, 1);
      const password = input.split(':')[1].trim()

      const occurrences = password.split(allowedChar).length - 1;
      if (occurrences >= minNumOcc && occurrences <= maxNumOcc) validPasswords++
    }
  }
  return validPasswords;
}

const validPasswordsPartTwo = () => {
  let validPasswords = 0;
  for (const input of inputs) {
    if (typeof input === 'string') {
      const range = input.match(/(\d+-\d+)/g)[0].split('-');
      const indexOne = parseInt(range[0], 10);
      const indexTwo = parseInt(range[1], 10);
      const allowedChar = input.match(/(\w:)/g)[0].substr(0, 1);
      let password = Array.from(input.split(':')[1])

      if ((password[indexOne] === allowedChar && password[indexTwo] !== allowedChar) || password[indexOne] !== allowedChar && password[indexTwo] === allowedChar) {
        validPasswords++;
      }
    }
  }
  return validPasswords;
}


console.log('Valid passwords Part 2: ', validPasswordsPartTwo())
console.log('Valid passwords Part 1: ', validPasswordsPart1())