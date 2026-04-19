#let __fonts_draft = (
  "Noto Sans Mono",
  "Droid Sans Mono",
  "LMTypewriter10",
  "CMU Typewriter Text",
)
#let __fonts_edit = (
  "Inter",
  "FreeSans",
  "Helvetica Neue",
  "TeX Gyre Heros",
  "Helvetica",
  "Arial",
)
#let __fonts_review = (
  "TeX Gyre Schola",
  "C059",
  "QTSchoolCentury",
  // "Century Schoolbook",
)
#let __fonts_release = (
  "New Computer Modern",
  "CMU Serif",
  "Latin Modern Roman 12",
)
#let __fonts_release_big = (
  "New Computer Modern",
  "CMU Serif",
  "Latin Modern Roman 17",
)


#let __show_heading(font: auto, spacing_ratio: 100%) = {
  return it => {
    v(spacing_ratio * 140% * 16mm * (9 - it.depth) / 9, weak: true)
    if font == auto {
      text(fill: black, stroke: 0.0em, weight: 500, it)
    } else {
      text(fill: black, font: __fonts_release_big, stroke: 0.0em, it)
    }
    v(spacing_ratio * 16mm * (9 - it.depth) / 9, weak: true)
  }
}

#let __phase_1_draft(show-header: false, doc) = {
  set page(margin: 29mm, width: 240mm, height: 240mm, fill: rgb("#fcf0dd"))
  set text(size: 10.6pt, font: __fonts_draft, tracking: 0.03em, spacing: 130%, fill: rgb("#001122"))
  set smartquote(enabled: false)
  set par(justify: false, leading: 1em, spacing: 3em, first-line-indent: 6em)
  show heading: __show_heading(font: auto, spacing_ratio: 125%)
  show ". ": ".    "
  show "! ": "!    "
  show "? ": "?    "
  doc
}
#let __phase_2_edit(show-header: false, doc) = {
  set page(margin: 9mm)
  set text(size: 13pt, font: __fonts_edit, fill: black.transparentize(40%), tracking: 0.017em)
  set smartquote(enabled: false)
  set par(justify: false, leading: 1em, spacing: 2.3em, first-line-indent: 4em)
  set heading(numbering: "1.1.1.1.1.1.  ")
  show heading: __show_heading(font: auto)
  let __styler__first_word(it) = text(fill: black, stroke: 0.012em, box(scale(reflow: true, x: 122%, it)))
  show ". ": ".  "
  show "! ": "!  "
  show "? ": "?  "
  show regex("([.!?]\s+)(\w+)"): it => {
    let element = it.text
    let m = element.match(regex("([.!?]\s+)(\w+)"))
    {
      m.captures.at(0)
      // linebreak()
      h(0.7em, weak: true)
      // sym.section
      // [~~]
      __styler__first_word(m.captures.at(1))
    }
  }
  doc
}
#let __phase_3_review(show-header: false, doc) = {
  set page(margin: 27mm)
  set text(size: 12pt, font: __fonts_review, fill: black.transparentize(0%), tracking: 0.02em)
  set par(justify: true, leading: 0.65em, spacing: 1.25em)
  show heading: __show_heading(font: auto)
  let __styler__first_word(it) = text(fill: black, weight: 500, it)
  show ". ": ". "
  show "! ": "! "
  show "? ": "? "
  show regex("([.!?]\s+)(\w+)"): it => {
    let element = it.text
    let m = element.match(regex("([.!?]\s+)(\w+)"))
    m.captures.at(0) + h(0.5em) + __styler__first_word(m.captures.at(1))
  }
  doc
}
#let __phase_4_release(show-header: false, doc) = {
  set page(margin: 38mm)
  set text(size: 11pt, font: __fonts_release)
  // set par(justify: true, leading: 0.65em, spacing: 1.25em)
  set par(justify: true)
  show heading: __show_heading(font: __fonts_release_big)
  doc
}


#let quadpass(doc, phase: 1, show-header: true) = {
  let newdoc = {
    if show-header {
      par[Phase #phase : #("???", "Draft", "Edit", "Review", "Release").at(phase, default: "???")]
      v(8mm)
    }
    doc
  }
  if phase == 1 { __phase_1_draft(show-header: show-header, newdoc) }
  if phase == 2 { __phase_2_edit(show-header: show-header, newdoc) }
  if phase == 3 { __phase_3_review(show-header: show-header, newdoc) }
  if phase == 4 { __phase_4_release(show-header: show-header, newdoc) }
}
