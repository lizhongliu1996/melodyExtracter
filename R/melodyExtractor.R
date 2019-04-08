#' function that remove the human vocal part melody
#'
#' @param songLoadPath path of the audio file
#' @param songSavePath path to save the song
#' @param compensate whether add low and high freq compensation
#' @param keyChange input semitones to change key
#' @return A wav file without vocal part
#'
#' @importFrom sound loadSample pitch left right Ops.Sample stereo saveSample
#'
#' @export
#'
#' @examples \dontrun{
#'  melodyExtractor(
#'    songLoadPath = "inst/extdata/ifonly.wav",
#'    songSavePath = "novocal3.wav",
#'    compensate = FALSE,
#'    keyChange = +2
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

  ## 5. add eq low and high pass
  ## 0-250, 3k-10k
  if(compensate == TRUE){
    lowCompensate <- eq(song, from = 70, to = 100, rate = 44100)
    #highCompensate <- eq(song, from = 5000, to = 7000, rate = 44100)
    newSong <- newSong + lowCompensate #+ highCompensate
  }

  ## 6. change the key
  if(!is.null(keyChange)){
    newSong = pitch(newSong, keyChange)
  }

  ## 7. output audio file
  saveSample(newSong, filename = songSavePath)

}
