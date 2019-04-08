#' function that do equalization for audio
#'
#' @param sound single channel sound
#' @param from frequency that you want to start
#' @param to frequency that you want to end
#' @param rate sampling rate of audio
#' @return single chanel sound file with frequency you want to change
#'
#' @importFrom stats filter sd
#' @importFrom phonTools windowfunc sinc
#' @importFrom utils tail
#' @export
#'
#' @examples \dontrun{
#'  song <- sound::loadSample("inst/extdata/ifonly.wav")
#'  left_song <- sound::left(song)
#'  test <- singlePanEQ(
#'       left_song,
#'       from = 250,
#'       to = 8000,
#'       rate = 44100
#'  )
#' }
#'

singlePanEQ <- function(sound, from, to, rate = 44100){

  order = 200
  tsout = 0
  soundout = 1
  sdin = sd (sound)

  maxamp = max(sound)
  n = seq(0, order-1, 1)
  Mi = (order-1) / 2

  fromrads = (((rate/2)-from) / rate) * pi
  torads = (to / rate) * pi
  fromrads2 = (from / rate) * pi

  fromh = (-1)^(n)*2*fromrads*sinc((2*fromrads)*(n-Mi))  ##min freq passed
  toh = 2*torads*sinc(2*torads*(n-Mi))  ##max freq passed
  fromh2 = 2*fromrads2*sinc(2*fromrads2*(n-Mi))

  fromh = fromh * windowfunc(length(fromh), type ='blackman')
  toh = toh * windowfunc(length(toh), type ='blackman')
  fromh2 = fromh2 * windowfunc(length(fromh2), type ='blackman')

  sound = c(rep(sound[1], order/2), sound, rep(tail(sound,1),order/2))

  if (from!=0 & to==rate/2) output = filter (sound, fromh, method = 'convolution')
  if (from==0 & to!=rate/2) output = filter (sound, toh, method = 'convolution')
  if (from!=0 & to!=rate/2) output = filter (sound, fromh2-toh, method = 'convolution')
  output = output[!is.na(output)]
  output = output/sd(output) * sdin

  output = output[-1]

  invisible (output)

}
