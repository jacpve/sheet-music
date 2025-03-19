\version "2.24.0"



\paper {
  % system-system-spacing = #'((basic-distance . 0.1) (padding . 0))
  % ragged-last-bottom = ##f
  %  ragged-bottom = ##t
  markup-system-spacing.padding = #1

  % % % % % % % Table of Content % % % % %
  %    				       %
  tocTitleMarkup = \markup \column {
    \fill-line \huge \bold { \null "CONTENIDO" \null }
    \hspace #1
  }

  tochimnumMarkup = \markup { \fromproperty #'toc:himnum }

  tocSeccMarkup = \markup \large {
    \column {
      \hspace #1
      \fill-line { \null \box \smallCaps \fromproperty #'toc:text \null }
      \hspace #1
    }
  }

  tocSubSeccMarkup = \markup \column {
    \hspace #1
    \fill-line { \null \italic \fromproperty #'toc:text \null }
    \hspace #1
  }

  tocItemMarkup = \markup {
    \fill-with-pattern #1 #RIGHT .
    \fromproperty #'toc:text \fromproperty #'toc:page
  }


  %  					 %
  % % % % % % % % Table of Content % % % % %


  %#(set-paper-size "office")
  %page-breaking = #ly:minimal-breaking
  indent = 0\cm

  % % % % % % % Titles % % % % % % % % % %
  %    				       %
  scoreTitleMarkup = \markup {
    \fill-line {
      \line {
        \bold \fontsize #9 \fromproperty #'header:himnonum \hspace #3 \override #'(baseline-skip . 3.5)
        \column {
          \bold \fontsize #7 \fromproperty #'header:title
          \small \italic \fontsize #1 \fromproperty #'header:vlema
        }
      }
      \override #'(baseline-skip . 2.5) \general-align #Y #CENTER
      \right-column {
        \fromproperty #'header:pasajea
        \fromproperty #'header:pasajeb
        \fromproperty #'header:pasajec
      }
    }

  }

  oddHeaderMarkup = \markup {
    \fill-line {
      \line { \smallCaps \normalsize \fromproperty #'header:section }    		\null
    }
  }

  evenHeaderMarkup = \markup {
    \fill-line {
      \null
      \line { \smallCaps \normalsize \fromproperty #'header:subsection }
    }
  }

  oddFooterMarkup = \markup {
    \fill-line {
      \null
      \line { \general-align #Y #DOWN { \epsfile #Y #6 #"Guitarra.eps" } \fromproperty #'header:guitarra }
      %  \line { \general-align #Y #DOWN { \epsfile #Y #6 #"clarinete.eps" } \fromproperty #'header:clarinete }
    }
  }
  % % % % % % % % Titles % % % % % % % % % %

  %print-all-headers = ##t
  %page-limit-inter-system-space = ##t
  %page-limit-inter-system-space-factor = 1
  %between-system-space = 1\cm
  %between-system-padding = #1
}


%


%%%%%%%% Ángulos para Introducción %%%%%%%%%%
anguloizq =
#'((moveto 0 0)
   (lineto 0 2)
   (lineto 2 2))
anguloder =
#'((moveto 0 0)
   (lineto 0 2)
   (lineto -2 2))

angizq =
{
  %\once \override Score.TextMark.break-align-symbols = #'(key-signature)
  %\once \override TextMark.self-alignment-Y = #UP
  %\once \override Score.RehearsalMark.extra-spacing-width = #'(0 . 0)
  \tweak outside-staff-priority 1
  % \once \override Score.TextMark.extra-offset = #'(0 . 1.5)
  % \once \override Score.TextMark.outside-staff-priority = ##f1
  %\once \override Score.TextMark.Y-offset = #-1
  \markLengthOn

  \textMark \markup { \override #'(line-cap-style . round) \override #'(line-join-style . round) \path #0.3 #anguloizq  }
}

angder = {

  %\once \override Score.TextMark.extra-offset = #'(0 . 1.5)
  \markLengthOn
  \textEndMark \markup { \override #'(line-cap-style . round) \override #'(line-join-style . round) \path #0.3 #anguloder  }
}

angfinal=  { \once \override Score.RehearsalMark.break-visibility = #end-of-line-visible \once \override Score.RehearsalMark.self-alignment-X = #RIGHT \angder }

%%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%

#(define (pcn in-pitches bass inversion
              context)
   (markup #:line ("(" (ignatzek-chord-names in-pitches bass
                                             inversion context) ")")))

besideCN = #(define-music-function
             (which-side added-text) (integer? string?)
             #{\once \override ChordNames.ChordName.stencil = #(lambda (grob)
                                                                 (ly:grob-set-property! grob 'text
                                                                                        (markup #:put-adjacent 0 $which-side ; #LEFT or #RIGHT
                                                                                                (ly:grob-property grob 'text) $added-text))
                                                                 (ly:text-interface::print grob))
             #})

#(define (left-parenthesis-ignatzek-chord-names in-pitches bass inversion context)
   (markup #:line ("( " (ignatzek-chord-names in-pitches bass inversion context))))

#(define (right-parenthesis-ignatzek-chord-names in-pitches bass inversion context)
   (markup #:line ((ignatzek-chord-names in-pitches bass inversion context) " )")))

LPC = { \set chordNameFunction = #left-parenthesis-ignatzek-chord-names }

RPC = { \set chordNameFunction = #right-parenthesis-ignatzek-chord-names }
NPC = { \unset chordNameFunction }


shortenstem = \override Score.Stem.details.stem-shorten = #'(50 40)

shortstem = \override Score.Stem.length-fraction = #0.95

% % % % % % % Table of Content % % % % %
%    				       %

tocSecc =
#(define-music-function (text) (markup?)
   (add-toc-item! 'tocSeccMarkup text))

tocSubSecc =
#(define-music-function (text) (markup?)
   (add-toc-item! 'tocSubSeccMarkup text))

%  					 %
% % % % % % % % Table of Content % % % % %

% % % % % % % accidentals % % % % % % % % %
forget = #(define-music-function (music) (ly:music?) #{
  \accidentalStyle forget
  #music
  \accidentalStyle modern
            #})

dodecaphonic = #(define-music-function (music) (ly:music?) #{
  \accidentalStyle dodecaphonic
  #music
  \accidentalStyle modern
                  #})

% % % % % % % % % % % % % % % % % % % % % % %% %

#(define (naturalize-pitch p)
   (let ((o (ly:pitch-octave p))
         (a (* 4 (ly:pitch-alteration p)))
         ;; alteration, a, in quarter tone steps,
         ;; for historical reasons
         (n (ly:pitch-notename p)))
     (cond
      ((and (> a 1) (or (eqv? n 6) (eqv? n 2)))
       (set! a (- a 2))
       (set! n (+ n 1)))
      ((and (< a -1) (or (eqv? n 0) (eqv? n 3)))
       (set! a (+ a 2))
       (set! n (- n 1))))
     (cond
      ((> a 2) (set! a (- a 4)) (set! n (+ n 1)))
      ((< a -2) (set! a (+ a 4)) (set! n (- n 1))))
     (if (< n 0) (begin (set! o (- o 1)) (set! n (+ n 7))))
     (if (> n 6) (begin (set! o (+ o 1)) (set! n (- n 7))))
     (ly:make-pitch o n (/ a 4))))

#(define (naturalize music)
   (let ((es (ly:music-property music 'elements))
         (e (ly:music-property music 'element))
         (p (ly:music-property music 'pitch)))
     (if (pair? es)
         (ly:music-set-property!
          music 'elements
          (map naturalize es)))
     (if (ly:music? e)
         (ly:music-set-property!
          music 'element
          (naturalize e)))
     (if (ly:pitch? p)
         (begin
          (set! p (naturalize-pitch p))
          (ly:music-set-property! music 'pitch p)))
     music))

naturalizeMusic =
#(define-music-function (m)
   (ly:music?)
   (naturalize m))

% % % % % % % accidentals % % % % % % % % %

% % % % % % % Chord Exceptions % % % % % % % % % %
%						 %


chExceptionMusic = {
  <c ees ges beses>1-\markup \concat { \normal-size-super ° \super 7 }
  <c e g a d'>1-\markup { \super "6(add9)" }
  <c f g>1-\markup { \super "sus" }
  <c f g bes>1-\markup { \super "7sus" }
  <c e g b>1-\markup \concat { "M" \super 7}
  %<c e g bes>1-\markup { \huge "7" }

}

chExceptions = #(append
                 (sequential-music-to-chord-exceptions chExceptionMusic #t)
                 ignatzekExceptions)

DSalFin = {
  \override Score.RehearsalMark.break-visibility = #end-of-line-visible
  \override Score.RehearsalMark.self-alignment-X = #RIGHT
  \override Score.RehearsalMark.outside-staff-padding = #1.5  \mark \markup \normalsize { "D.S. al Fin" }
}

%%%%%%%% CORO %%%%%%%%%%%%%%%%%%%

coroalt ={
  \override Score.RehearsalMark.break-align-symbols = #'(key)
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT
  \override Score.RehearsalMark.extra-spacing-width = #'(0 . 3)
  \mark \markup { "CORO" }
}

corobar ={
  \override Score.TextMark.break-align-symbols = #'(staff-bar)
  \once \override Score.TextMark.self-alignment-X = #LEFT
  \override Score.TextMark.extra-spacing-width = #'(0 . 0)

  \textMark \markup { "CORO" }
}

coroclef = {
  % \once \override Score.TextMark.extra-spacing-width = #'(0 . 3)
  \once \override Score.TextMark.self-alignment-X = #CENTER
  \tweak break-align-symbols #'(clef)
  \tweak font-size 1.5
  %  % \markLengthOn
  \textMark \markup { "CORO" }
}

% % % % % %  Double Slurs % % % % % %

dst = \set doubleSlurs = ##t

dsf = \set doubleSlurs = ##f

% % % % % % % % % Part combine % % % % % % % % % % %

pc = \partCombineChords
pa = \partCombineAutomatic


% % % % % % % % % Part combine % % % % % % % % % % %

\layout {
  \context {
    \Score
    \consists Lyric_text_align_engraver

  }

  \context {
    \Staff  {
      \accidentalStyle modern
      \set Timing.beamExceptions = #'()
      \set Timing.baseMoment = #(ly:make-moment 1/4)
      \set Timing.beatStructure = 1,1,1,1

      \once \override Staff.VerticalAxisGroup.default-staff-staff-spacing =
      #'(
          (basic-distance . 15)
          (minimum-distance . 15)
          (padding . 5))
    }
  }
  \context {
    \Lyrics {
      %\override LyricText.X-offset = #'()
      \override VerticalAxisGroup.staff-affinity = #CENTER
    }
  }
  \context {
    \ChordNames {
      % \set majorSevenSymbol = \markup { M7 }
      \set chordNameExceptions = #chExceptions
    }
  }
}
\midi {
  \context { \ChordNames \remove "Staff_performer" }
}


globalLyrics =
#(define-music-function
  (parser location firstLabel)
  (string?)
  #{
    {
      \override LyricHyphen.minimum-distance = #1.0 % Ensure hyphens are visible
      %\set fontSize = #-1
      \override LyricText.font-family = #'roman
      \override StanzaNumber.font-family = #'roman
      \override StanzaNumber.font-series = #'bold
      \set stanza = #firstLabel
      \override VerticalAxisGroup.staff-affinity = #CENTER
    }
  #})

%{
convert-ly.py (GNU LilyPond) 2.24.4  convert-ly.py: Processing `'...
Applying conversion: 2.19.2, 2.19.7, 2.19.11, 2.19.16, 2.19.22,
2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.39, 2.19.40, 2.19.46,
2.19.49, 2.20.0, 2.21.0, 2.21.2, 2.22.0, 2.23.1, 2.23.2, 2.23.3,
2.23.4, 2.23.5, 2.23.6, 2.23.7, 2.23.8, 2.23.9, 2.23.10, 2.23.11,
2.23.12, 2.23.13, 2.23.14, 2.24.0
%}
