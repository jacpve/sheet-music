globalLyrics =
#(define-music-function
  (parser location firstLabel)
  (string?)
  #{
    {
      \override LyricHyphen.minimum-distance = #1.0 % Ensure hyphens are visible
      \set fontSize = #-1
      \override LyricText.font-family = #'roman
      \override InstrumentName.font-family = #'roman
      \override InstrumentName.font-series = #'regular
      \override InstrumentName #'X-offset = #2.5
      \override InstrumentName #'font-size = #-1
      \override StanzaNumber.font-family = #'roman
      \override StanzaNumber.font-series = #'bold
      \set stanza = #firstLabel
      \override VerticalAxisGroup #'staff-affinity = #CENTER
    }
  #})

fillTradScore =
#(define-music-function
  (parser location topA topB bottomA bottomB songChords zoomLevel)
  (ly:music? ly:music? ly:music? ly:music? ly:music? number?)
  #{
    <<
      $songChords
      \new Lyrics = "topVerse" \with {
        % lyrics above a staff should have this override
        \override VerticalAxisGroup.staff-affinity = #DOWN
      }
      \new TradStaff = "top" \with {
        printPartCombineTexts = ##f
        \magnifyStaff $zoomLevel
        \RemoveAllEmptyStaves
      }
      <<
        \new Voice \with {

        } << \partCombine #'(2 . 20) $topA $topB >>
        \removeWithTag #'slidesOnly \all_verses
      >>
      \new TradStaff = "bottom" \with {
        printPartCombineTexts = ##f
        \magnifyStaff $zoomLevel
        \RemoveAllEmptyStaves
      } <<
        \new Voice \with {

        } { \clef bass << \partCombine #'(2 . 20) $bottomA $bottomB >> }
        \bottom_verses
        \top_verse
      >>
    >>
  #})