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


function withMessage (m) {
  console.table({
    ...uint8arrayToBinary(m.data),
    timestamp: m.timeStamp,
    data: m.data.toString()
  })
}
