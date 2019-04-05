#' function that remove the human vocal part melody
#'
#' @param songLoadPath path of the audio file
#' @param fileType audio file type, it is a wav file or mp3 file or midi file
#' @param songSavePath path to save the song
#' @param compensate whether add low and high freq compensation
#' @param keyChange input semitones to change key
#' @return A wav file without vocal part
#'
#' @importFrom seewave savewav
#' @importFrom sound loadSample pitch left right Ops.Sample
#'
#' @export
#'
#' @examples \dontrun{
#'  melodyExtractor(
#'    songLoadPath = "~/Downloads/remember.wav",
#'    fileType = "mp3"),
#'    songSavePath = "~/song/remember.wav",
#'    compensate = TRUE,
#'    keyChange = -5
#'  )
#' }
#'

melodyExtractor <- function(songLoadPath,
                            songSavePath,
                            compensate = FALSE,
                            keyChange = NULL
                           ){

  ## 1. load wav file
  song <- loadSample(songLoadPath)

  ## 2. divided into left mono and right mono
  leftPan <- left(song)
  rightPan <- right(song)

  ## 3. combine left and right by left - right
  noVocalSong <- leftPan - rightPan

  ## 4. stereo the combined audio
  newSong <- stereo(noVocalSong, noVocalSong)

  ## 5. change the key
  if(!is.null(keyChange)){
    newSong = pitch(newSong, keyChange)
  }

  ## 5. add eq low and high pass
  ## 0-250, 3k-10k
  if(compensate == TRUE){
    lowCompensate <- eq(song, from = 0, to = 250, rate = 44100)
    highCompensate <- eq(song, from = 3000, to = 10000, rate = 44100)
    newSong <- newSong + lowCompensate + lowCompensate
  }

  ## 6. output audio file
  savewav(newSong, filename = songSavePath)

}
