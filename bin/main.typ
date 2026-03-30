#import "template.typ": *

#show: ieee.with(
  title: [2026 Technical Design Report],
  abstract: include "../0-abstract.typ",
  authors: json("../data/leaders.json"),
  // index-terms: ("Scientific writing", "Typesetting", "Document creation", "Syntax"),
  // bibliography: bibliography("../5-refs.bib"),
)

= Competition Strategy
#include "../1-compeition-strategy.typ"

= Design Strategy
#include "../2-design-strategy.typ"

= Testing Strategy
#include "../3-testing-strategy.typ"

= Acknowledgements
#include "../4-acknowledgements.typ"

#bibliography("../5-refs.bib", full: true)

#set page(
  columns: 1,
  margin: 1in,
)

#show: appendix
#set par(
  first-line-indent: (amount: 0in, all: false),
  spacing: 1.2em
)
// #show heading.where(level:3): it => block(text(1em, it.body))
#show heading.where(level: 2): it => context{
  if counter(heading).get() != (6,1) {pagebreak()}
  it
}

#set image(fit: "cover", width: 100%)
#set grid(column-gutter: .125in)
#include "../6-appendix.typ"