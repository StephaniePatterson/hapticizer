SinOsc s;
OscRecv recv;
6449 => recv.port;
recv.listen();

WvOut wavOut => dac;  
"output.wav" => wavOut.wavFilename;

Gain g;

OscEvent pitch_event;
OscEvent loudness_event;
recv.event("/pitch, f") @=> pitch_event;
recv.event("/loudness, f") @=> loudness_event;
1::second => dur timeout;
now => time lastMessage;
<<< "Ready" >>>;

spork ~ watchsilence();

while (true) {
    pitch_event => now;
    loudness_event => now;
    while (pitch_event.nextMsg() && loudness_event.nextMsg()) {
        now => lastMessage;
        pitch_event.getFloat() => float newpitch;
        loudness_event.getFloat() => float newgain;
        <<< "Received pitch:", newpitch, "at time", now >>>;
        <<< "Received gain:", newgain >>>;
        newpitch => s.freq;
        newgain => g.gain;
        s => g => wavOut => dac;
    }
}

wavOut.closeFile();

//Function that silences sound when no signal has been received
fun void watchsilence() {
    while (true) {
        timeout => now;
        if (now - lastMessage >= timeout) {
            0 => g.gain;
        }
    }
}