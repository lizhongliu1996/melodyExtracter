# How to install
run `devtools::install_github("lizhongliu1996/melodyExtracter")` in R console

# melodyExtracter

Having trouble find the accompaniment of a new song which you prepare for singing to your classmates or colleagues? 

Tired of transcribing a song by repeat listenning to it thousands of times? 

Sick of spending so much time on clicking notes on digital work station and finding the matched tone color of each instruments? 

Based on some acoustic technologies, it is possible that we
can save you much efforts through our algorithm.

  Usually a typical commercial song is composed of many tracks including vocal,
  piano, percussion, guitar, orchestra and sometimes electronic synthesizer. According 
  to the definition of "entropy", a parameter to reflect the degree of chaos, entropy 
  is constantly increasing, and the increasing process is irreversible. For example, it is easy to cook a dish with recipe, but   it is pretty hard to know the ingredients and spices given a cooked dish without recipe. Based on that, after rendering many
  tracks into one single wav or mp3 file, it is a pretty hard challenge to remove a track, so 
  how to get ride of the melody is quite a problem especially when you cannot find the midi 
  file online.
  
  Luckily, French mathematician Fourier demonstrated the rule that any complex waveform can be
  seen as a superposition of several sine waves. The Fourier transfrom is a powerful weapon that 
  can easily separating the sine waves which make up the composite waveform and transform them into 
  a spectrogram, which we can easily see the characteristics of composite waveform and do some 
  manipulations to get the desire waveform.  Sound is one type of mechanical wave with salient
  features, thus we can use Fourier transformation to play some interesting tricks in music.
  
  This package refers to the principle of how the headphone brand "BOSE" remove the noise by adding
  the polarize reverse wave of specifical frenquency we want to get rid of, however rightnow we 
  can only deal  with song that has mono vocal part with 0 pan.
