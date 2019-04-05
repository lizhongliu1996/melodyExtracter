#### this function so fft then keep only the high frequency signal(
#high pass EQ)
eq <- function(sound, from , to, rate = 44100){
  order = 200
  tsout = 0
  soundout = 1
  fs = 44100
  sound = sound$sound
  sdin = sd (sound)

  maxamp = max(sound)
  M = order
  n = seq(0,M-1,1)
  Mi = (M-1) / 2
  fromrads = (((fs/2)-from) / fs) * pi
  torads = (to / fs) * pi
  fromrads2 = (from / fs) * pi

  fromh = (-1)^(n)*2*fromrads*sinc((2*fromrads)*(n-Mi))  ##min freq passed
  toh = 2*torads*sinc(2*torads*(n-Mi))  ##max freq passed
  fromh2 = 2*fromrads2*sinc(2*fromrads2*(n-Mi))

  fromh = fromh * windowfunc(length(fromh), type ='blackman')
  toh = toh * windowfunc(length(toh), type ='blackman')
  fromh2 = fromh2 * windowfunc(length(fromh2), type ='blackman')

  if (pad) sound = c(rep(sound[1], order/2), sound, rep(tail(sound,1),order/2))
  if (from!=0 & to==fs/2) output = filter (sound, fromh, method = 'convolution')
  if (from==0 & to!=fs/2) output = filter (sound, toh, method = 'convolution')
  if (from!=0 & to!=fs/2) output = filter (sound, fromh2-toh, method = 'convolution')

  if (pad) output = output[-1]

  tmp$sound = output
  output = tmp

  invisible (output)
}
