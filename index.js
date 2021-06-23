const fs = require('fs');
const Parser = require('jison').Parser;

const grammar = fs.readFileSync('grammar.jison', {
  encoding: 'utf8',
  flag: 'r',
});

const parser = new Parser(grammar);

// generate source, ready to be written to disk
// const parserSource = parser.generate();

const input = require('./input.json')

console.log('\n\n\n');

for (element of input) {
  let expr = element.expr;
  console.log('>', expr);
  console.log('  R:', parser.parse(expr));
  console.log('\n');
}

expr = 'Se 40 é maior que 20 escreva "Sim" senão escreva "Nao"';
console.log('>', expr);
parser.parse(expr);
console.log('\n');

expr = 'Se 35 é menor que 20 escreva "Sim" senão escreva "Nao"';
console.log('>', expr);
parser.parse(expr);
console.log('\n');

expr = 'Se 10 é igual a 10 escreva "Sim" senão escreva "Nao"';
console.log('>', expr);
parser.parse(expr);
console.log('\n');