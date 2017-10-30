const record = require('node-record-lpcm16');
const _request = require('request');

// Imports the Google Cloud client library
const Speech = require('@google-cloud/speech');

// Your Google Cloud Platform project ID
const projectId = 'mayfesapp2017';

// Instantiates a client
const speech = Speech({
  projectId: projectId
});
console.log(speech);

// The encoding of the audio file, e.g. 'LINEAR16'
const encoding = 'LINEAR16';
// The sample rate of the audio file in hertz, e.g. 16000
const sampleRateHertz = 16000;

// The BCP-47 language code to use, e.g. 'en-US'
const languageCode = 'ja-JP';

const request = {
    config: {
        encoding: encoding,
        sampleRateHertz: sampleRateHertz,
        languageCode: languageCode
    },
    interimResults: false // If you want interim results, set this to true
};

// Create a recognize stream
const recognizeStream = speech.streamingRecognize(request)
.on('error', console.error)
.on('data', function(data) {
    if (data.results[0] && data.results[0].alternatives[0]) {
        var transcription = data.results[0].alternatives[0].transcript;
        var options = {
            uri: "localhost",
            headers: {
                "Content-type": "application/json",
            },
            json: {
                "transcription": transcription
            }
        };
        _request.post(options, function(error, response, body){});
        console.log("Transcription = " + transcription + "\n");
    } else {
        console.log("Reached transcription time limit, press Ctrl+C\n");
    }
});

// Start recording and send the microphone input to the Speech API
record.start({
    sampleRateHertz: sampleRateHertz,
    threshold: 0,
    // Other options, see https://www.npmjs.com/package/node-record-lpcm16#options
    verbose: false,
    recordProgram: 'rec', // Try also "arecord" or "sox"
    silence: '10.0'
})
.on('error', console.error)
.pipe(recognizeStream);

console.log('Listening, press Ctrl+C to stop.');
