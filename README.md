# melodyExtracter

Having trouble find the accompaniment of a new song which you prepare for singing to your classmates or colleagues? 

Tired of transcribing a song by repeat listenning to it thousands of times? 

Based on some bioacoustic technologies, it is possible that we
can save you much efforts through our algorithm.

  Usually a typical commercial song is composed of many tracks including vocal,
  piano, percussion, guitar, orchestra and sometimes electronic synthesizer. According 
  to the definition of "entropy", a parameter to reflect the degree of chaos, entropy 
  is constantly increasing, and the increasing process is irreversible. For example, mixing
  juice with coca, then it is impossible to isolate coca. Based on that, when render many
  tracks into a wav or mp3 file, it is a pretty hard challenge to remove a track, so get 
  ride of the melody is quite a problem especially when you cannot find the midi file online.
  
  Luckily, French mathematician Fourier demonstrated the rule that any complex waveform can be
  seen as a superposition of several sine waves. The Fourier transfrom is a power weapon that 
  can easily separating the sine waves that make up the composite waveform and transform into 
  a spectrogram, which we can easily see the characteristics of composite waveform and do some 
  manipulations to get the desire waveform.  Sound is one type of mechanical wave with salient
  features, thus we can use Fourier transfrom to play some interesting tricks in music.
  
  This package refers to the principle of how the headphone brand Boss remove the noise by adding
  the polarize reverse wave of specifical frenquency we want to get rid of, however rightnow we 
  can only deal  with song that has mono vocal part with 0 pan.
