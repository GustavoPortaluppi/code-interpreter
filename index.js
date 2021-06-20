const fs = require('fs');
const Parser = require('jison').Parser;

const grammar = fs.readFileSync('grammar.jison', {
  encoding: 'utf8',
  flag: 'r',
});

const parser = new Parser(grammar);

// generate source, ready to be written to disk
// const parserSource = parser.generate();

let expr;

console.log('\n\n\n');

expr = '5 + 5';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = '5 + -7';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = '3 + (5 * 2)';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = '25 / cinco + (um + um)';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = '7 + (5^3 * 2)';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = 'Qual é o dobro de (um + um)?';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = 'Qual é o triplo de (4 + dois)?';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = 'Qual é o dobro de 7?';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = '[5]';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = '[5, 8, dois]';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = 'Qual é o maior elemento da série [5, 8, dois, um, 9]?';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = 'Qual é o menor elemento da série [4, um, 3, 9]?';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = 'Qual é o terceiro elemento da série [7, oito, dez, 2]?';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

expr = 'Qual é o quinto elemento da série [7, oito, dez, 2, 1, 2, 7, três]?';
console.log('>', expr);
console.log('  R:', parser.parse(expr));
console.log('\n');

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
