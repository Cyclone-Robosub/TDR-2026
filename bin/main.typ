#import "template.typ": *
#import "@preview/oasis-align:0.3.3": *

#show: ieee.with(
  title: [2026 Technical Design Report],
  abstract: include "../0-abstract.typ",
  authors: json("../data/leaders.json"),
  // index-terms: ("Scientific writing", "Typesetting", "Document creation", "Syntax"),
  bibliography: bibliography("../5-refs.bib"),
)

= Competition Strategy
#include "../1-compeition-strategy.typ"

= Design Strategy
#include "../2-design-strategy.typ"

= Testing Strategy
#include "../3-testing-strategy.typ"

= Acknowledgements
#include "../4-acknowledgements.typ"

#bibliography("../5-refs.bib")

#set page(
  columns: 1,
  margin: 1in,
)

#show: appendix
#include "../6-appendix.typ"