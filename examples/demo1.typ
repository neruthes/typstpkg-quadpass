#import "../src/quadpass.typ": *

// #show: quadpass.with(phase: 1)
// #show: quadpass.with(phase: 2)


#set underline(offset: 4pt)
#let mydoc = [
  = Demo Doc For Quadpass Package

  == Old Memory
  I recall that around year 2014 there was an interesting Markdown editor for Mac OS X.
  It featured a 4-phase workflow offering distinct text styles.
  The first phase was draft phase, where the font was monospace and text characters not in the current sentence were dimmed,
  offering good attention guiding.

  Many years later, I no longer use Mac OS X, rarely use Markdown to write serious stuff,
  and hardly edit individual text files without a repository context.
  However, I may have situations where preprint manuscript and final release need to be distinguished in styling.
  And I thought, the manuscript phase requires better readability.
  So I decided to resembe the 4-phase workflow using Typst.

  == My Work
  I would make a package #underline[quadpass] and offer API #underline[\#show: quadpass.with(phase: 1)]
  to typeset a document in draft phase styling.
  In the draft phase, we do not need to optimize for actual printing, so I use a soft yellow-ish ivory color as page background and a square page geometry,
  and the text is bigger to easily naviagte on a modern monitor.
  Also, the inter-word, inter-sentence, inter-line, and inter-paragraph spacings are increased.




  // == Hallo Welt
  // #par(lorem(190))
  // #par(lorem(190))
]


#quadpass(phase: 1, mydoc)
// #quadpass(phase: 2, mydoc)
// #quadpass(phase: 3, mydoc)
// #quadpass(phase: 4, mydoc)
