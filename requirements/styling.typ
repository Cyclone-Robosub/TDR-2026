#let mission-requirements(
  path,
  prefix: "MR-"
) = {
  
  let data =  csv(path + ".tsv", delimiter: "\t", row-type: dictionary)

  show figure.where(kind: prefix): it => {
    set align(left)
    it.supplement
    it.counter.display(it.numbering)
  }
  
  table(
    columns: (5em, auto), 
    [ID], [Requirement],
    ..data.map(it => (
      [#figure([],
        kind: prefix,
        supplement: prefix,
        numbering: "1",
      ) #label("requirement:" + it.Keyword)], 
      it.Requirement)
    ).flatten()
  )
  
}


#let system-requirements(
  path,
  prefix: "SR-"
) = {
  
  let data =  csv(path + ".tsv", delimiter: "\t", row-type: dictionary)

  show figure.where(kind: prefix): it => {
    set align(left)
    it.supplement
    it.counter.display(it.numbering)
  }
  
  table(
    columns: (5em, 6em, auto, auto), 
    [ID], [Type],[Description], [Motivation],
    ..data.map(it => (
      [#figure([],
        kind: prefix,
        supplement: prefix,
        numbering: "1",
      ) #label("requirement:" + it.Keyword)], 
      it.at("Requirement Type"), it.Description, it.Motivation)
    ).flatten()
  )
  
}
