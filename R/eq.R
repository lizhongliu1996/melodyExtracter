#' function that do equalization for audio.
#'
#' @param song song file loaded
#' @param from frequency that you want to start
#' @param to frequency that you want to end
#' @param rate sampling rate of audio
#' @return wave file with frequency you want to change
#'
#' @export
#'
#' @examples \dontrun{
#' ifonly <- loadSample("data/ifonly.wav")
#' ifonly_eq <- eq(
#'    song = ifonly,
#'    from = 400,
#'    to = 800,
#'    rate = 44100
#'  )
#' }
#'
eq <- function(song, from , to, rate = 44100){

  sound_left = song$sound[1,]
  sound_right = song$sound[2,]

  temp = song

  ##for left pan
  leftAfterEQ <- singlePanEQ(
          sound_left,
          from = from,
          to = to,
          rate = rate
        )

  rightAfterEQ <- singlePanEQ(
          sound_right,
          from = from,
          to = to,
          rate = rate
  )

  temp$sound[1,] <- leftAfterEQ
  temp$sound[2,] <- rightAfterEQ

  invisible(temp)

}
