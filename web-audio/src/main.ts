import './style.css'

const deviceName = "Elektron Digitakt Digitakt in 1"

navigator['requestMIDIAccess']().then(withMidi)

function withMidi (midi) {
  const digitaktInput = Array.prototype.filter.call(
    [...midi.inputs.values()],
    (f) => f.name === deviceName
  )[0]

  if (!digitaktInput) { return }

  console.log('Connecting to', digitaktInput)
  digitaktInput.addEventListener('midimessage', withMessage)
}

function uint8arrayToBinary (arr) {
  return [...arr].map(a => a.toString(2).padStart(8, '0'))
}

let r = 0;
let g = 240;
let b = 140;

function withMessage (m) {
  if (m.data[0] === 192) {
    r = Math.sin(m.data[1]/127)*255*0.5+255*0.5
  }
  if (m.data[0] === 208) {
    g = Math.sin(m.data[1]/127)*255*0.5+255*0.5
  }
  if (m.data[0] === 176) {
    b = Math.sin(m.data[2]/127)*255*0.5+255*0.5
  }

  document.querySelector(':root').style.setProperty('--bg-color', `rgb(${r}, ${g}, ${b})`)
  console.table({
    ...uint8arrayToBinary(m.data),
    timestamp: m.timeStamp,
    data: m.data.toString()
  })
}
