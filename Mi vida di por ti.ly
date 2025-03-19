\version "2.24.4"
\include "Globals_Celebremos su Gloria.ly"
\include "left-aligned lyrics.ly"

Timeline = \new Voice {
  \numericTimeSignature \time 6/8
  \partial 8
  s8 | s2.*3 | s4. s4 \break
  s8 | s2.*3 | s4. s4 \break
  \once \override Score.TextMark.extra-offset = #'(-1 . 0) \angizq
  s8 | s2.*3 | s4. s4
  \once \override Score.TextMark.extra-offset = #'(0 . 4.5) \angder
}

MVDPTglobalt = {
  \key bes \major

}
MVDPTglobalb = {
  \clef "bass"
  \key bes \major
  \numericTimeSignature \time 6/8
}

MVDPTChords = \chordmode {
  \override ChordName.Y-extent = #'(0 . 2.5)
  s8 bes2. es bes4. f:7 bes2.
  bes2. es bes4. f:7 bes2.
  f:7 bes f:7 bes
}

MVDPTAltChords = \chordmode {
  \transpose aes' g' { \MVDPTChords }
}

MVDPTmelodyOne = \relative c' {
  \MVDPTglobalt
  % system #1
  \partial 8 f8 | 4 8 d4 f8 | g4.( bes8 a) g | f4 8 es4 f8 | d4.~ 4

  % system #2
  f8 | 4 8 d4 f8 | g4.( bes8 a) g | f4 8 a g a | bes4.~ 4

  % system #3
  \repeat volta 2 { bes8 | c4 8 8( bes) a | bes4 8 f4 bes8 | a4 8 8 g a | bes4.~4 }

}

MVDPTmelodyTwo = \relative c' {
  % system #1
  \partial 8 d8 | 4 8 bes4 d8 | es4.( g8 f) es | d4 8 c4 a8 | bes4.~ 4

  % system #2
  d8 | 4 8 bes4 d8 | es4.( g8 f) es | d4 f8 es4 8 | d4.~ 4

  % system #3
  \repeat volta 2 { d8 | es4 8 8( d) c | d4 8 4 8 | es4 8 4 8 | d4.~ 4 }

}


MVDPTaccOne = \relative c' {
  \MVDPTglobalb
  % system #1


  % system #2


  % system #3


  % system #4


  % system #5


  % system #6

}

MVDPTaccTwo = \relative c {
  % system #1


  % system #2


  % system #3


  % system #4


  % system #5


  % system #6

}

MVDPTaligner = \relative c'' {
  \MVDPTmelodyOne
}

MVDPTverseOne = \lyricmode {
  \set stanza = "1."


}

MVDPTverseTwo = \lyricmode {
  \set stanza = "2."


}

MVDPTverseThree = \lyricmode {
  \set stanza = "3."


}

MVDPTverseFour = \lyricmode {
  \set stanza = "4."


}

\bookpart {
  \tocItem \markup { Alabad al gran Rey }
  \paper {
    % page-count = #1

    oddFooterMarkup = \markup {
      \fill-line {
        \null
        %  \line { \general-align #Y #DOWN { \epsfile #Y #6 #"clarinete.eps" } \fromproperty #'header:clarinete }
        \line { \general-align #Y #DOWN { \epsfile #Y #6 #"Guitarra.eps" } \fromproperty #'header:guitarra }

      }
    }

    evenFooterMarkup = ""
  }

  \header {
    title = ##f
    section = "NUESTRO SEÑOR JESUCRISTO"
    subsection = "SU PASIÓN Y MUERTE"
    guitarra = \markup { Si \flat (Capo 1 - La) }
    %guitarra = \markup { Si \flat (Capo 1 - La) }
  }

  \score {
    <<
      \new ChordNames \with { \remove "Staff_performer" } {
        \override ChordName.font-series = #'bold
        \MVDPTChords
      }
      \new ChordNames \with { \remove "Staff_performer" } {
        \italianChords
        \MVDPTAltChords
      }
      \new Staff \with { printPartCombineTexts = ##f }
      <<
        \Timeline

        <<
          { \partCombine #'(0 . 20) \MVDPTmelodyOne \MVDPTmelodyTwo }
          \new NullVoice = "MVDPTaligner" \MVDPTaligner
          \new Lyrics \lyricsto "MVDPTaligner" { \MVDPTverseOne }
          \new Lyrics \lyricsto "MVDPTaligner" { \MVDPTverseTwo }
          \new Lyrics \lyricsto "MVDPTaligner" { \MVDPTverseThree }
          \new Lyrics \lyricsto "MVDPTaligner" { \MVDPTverseFour }
        >>
      >>
      \new Staff \with { printPartCombineTexts = ##f }

      { \partCombine #'(0 . 20) \MVDPTaccOne \MVDPTaccTwo }
    >>
    \header {
      title = "Mi Vida di por ti"
      himnonum = "198"
      vlema = "Por todos murió, para que los que viven, ya no vivan para sí. 2 Co. 5:15"
      pasajea = "2 Co. 5:11-21"
      pasajeb = "Fil. 2:1-11"
      pasajec = "Jn. 10:1-15"
    }
    \layout {
      \context {
        \Score
        %\override NonMusicalPaperColumn.page-break-permission = ##f
        chordChanges = ##f

      }
      \context {
        \Staff {
          \set doubleSlurs = ##t
          \set Timing.beamExceptions = #'()
          \set Timing.baseMoment = #(ly:make-moment 1/8)
          \set Timing.beatStructure = 2, 1, 2, 1

          \once \override Staff.VerticalAxisGroup.default-staff-staff-spacing =
          #'(
              (basic-distance . 9)
              (minimum-distance . 7)
              (padding . 1)
              (stretchability . 5))
        }
      }
    }
    \midi {
      \tempo 4=100
    }
  }
}
