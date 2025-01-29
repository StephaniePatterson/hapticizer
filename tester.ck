SinOsc s;
100 => s.freq;
s => dac;
<<< "Playing sine wave" >>>;
2::second => now;

PulseOsc p;
100 => p.freq;
p => dac;
<<< "Playing pulse wave" >>>;
2::second => now;

SqrOsc q;
100 => q.freq;
q => dac;
<<< "Playing square wave" >>>;
2::second => now;

TriOsc t;
100 => t.freq;
t => dac;
<<< "Playing triangle wave" >>>;
2::second => now;

SawOsc w;
100 => w.freq;
w => dac;
<<< "Playing sawtooth wave" >>>;
2::second => now;