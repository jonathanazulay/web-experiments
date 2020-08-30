const obj = { Hello: 'test' }
console.log('Hello', obj)
import('./test.js').then(mod => {
  console.log(mod)
})

