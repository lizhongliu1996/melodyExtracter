#' function that remove the human vocal part melody
#'
#' @param songLoadPath path of the audio file
#' @param fileType audio file type, it is a wav file or mp3 file or midi file
#' @param songSavePath path to save the song
#' @param compensate whether add low and high freq compensation
#' @param keyChange input semitones to change key
#' @return A wav file without vocal part
#'
#' @importFrom tuneR readMidi readMP3 readWave mono stereo
#' @importFrom seewave savewav
#' @importFrom sound pitch
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
### this function that remove the human vocal part melody
melodyExtractor <- function(songLoadPath,
                            fileType = c("wav","mp3", "midi"),
                            songSavePath,
                            compensate = FALSE,
                            keyChange = NULL
                           ){

  ## 1. first load song
  fileType <- match.arg(fileType)
  switch(
    fileType,
         "wav" = {
           song = readWave(songLoadPath)
         },
         "mp3" = {
           song = readMP3(songLoadPath)
         },
         "midi" = {
           song = readMidi(songLoadPath)
         }
  )

  ## 2. divided into left mono and right mono
  leftSong <- mono(song,"left")
  rightSong <- mono(song,"right")

  ## 3. combine left and right by left - right
  noVocalSong <- leftSong - rightSong

  ## 4. stereo the combined audio
  newSong <- stereo(noVocalSong, noVocalSong)

  ## 5. change the key
  if(!is.null(aVariable)){
    newSong = pitch(newsong, keyChange)
  }

  ## 5. add eq low and high pass
  if(compensate == TRUE){
    lowCompensate <- lowPass(song)
    highCompensate <- highPass(song)
    newSong <- newSong + lowCompensate + lowCompensate
  }

  ## 6. output audio file
  savewav(newSong, filename = songOutPath)

}
