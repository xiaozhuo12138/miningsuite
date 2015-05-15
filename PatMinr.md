# _PatMinr_ module #

> Overall description of the architecture

## Classes ##

`pat.occurrence`: PatOccurrence

to be continued…


## How it works ##

### `mus.score`:`Process_notes` ###

Each note:

```
mus.score:Process (note)
```

### `mus.score`:`Process` (note) ###

Each previous note syntagmatically leading to the note:

  * Constructs a syntagmatic relation:
```
syntagm = pat.syntagm (previous_note -> note)
```

  * Creates a `pat.occurrence` ø of the elementary note pattern and call:
```
pat.occurrence.memorize (ø -> syntagm)
```

### `pat.syntagm` (previous\_note -> note) ###

Constructs a syntagmatic relation between previous and current note.

  * First, tries to extend any cyclic occurrence by calling:
```
pat.occurrence.track_cycle (occurrence -> syntagm)
```

  * Then tries to extend all the pattern occurrences (including cycles) ending at the previous note, in decreasing order of specificity, with the new syntagmatic relation by calling:
```
pat.occurrence.memorize (occurrence -> syntagm, not_specific_general_patterns)
```
where `not_specific_general_patterns` is the set of patterns more general than the patterns of the more general occurrences. These general patterns will be already considered by more general occurrences, so don't need to be considered by the current more specific occurrence.

### `pat.occurrence.memorize` (occurrence -> syntagm, not\_specific\_general\_patterns) ###

  * 1. Checks if occurrence -> syntagm can be recognised as a known pattern extension of the occurrence's pattern `pattern`, by calling
```
pat.pattern.remember (pattern, occurrence -> syntagm)
```

  * 2. Do the same for any pattern `pattern` more general than the occurrence pattern that meet the following conditions:
    * It is not member of the set `not_specific_general_patterns` (which will be considered already by more general occurrences).
    * It can be applied to the current context (cf. `pat.pattern.incompatible`).
    * It is not more general than a cycle currently developing up to the occurrence's last note.

  * 3. Check if  occurrence -> syntagm can be identified with a previously memorised extension, leading to a new pattern extension, by calling:
```
pat.memostruct.learn (memory, occurrence -> syntagm)
```
where `memory` is the associative memory storing the extensions of the occurrence's pattern.

  * 4. Do the same for the associative memory `memory` related to any pattern more general than the occurrence pattern that meet the following conditions:
    * It is not member of the set `not_specific_general_patterns` (which will be considered already by more general occurrences).
    * It can be applied to the current context (cf. `pat.pattern.incompatible`).

### `pat.pattern.remember` (pattern, occurrence -> syntagm) ###

Checks if occurrence -> syntagm can be recognised as a known pattern extension of `pattern`.

For each `child` of `pattern`, with parametric description `param`:

  * If necessary, generalise `param` so that it can apply to the `syntagm`'s description. If there is total incompatibility, skip that `child`.

  * If the occurrence is cyclic, generalise `param` so that it can apply to the description of the next phase of the cycle. If there is total incompatibility, skip that `child`.

  * Skip that child if it can be found already associated to `syntagm`.

%  **In the special case where `pattern` is more general than `occurrence`'s pattern (step 3 in calling function `pat.occurrence.memorize`):
%Checks if the resulting pattern would be closed by calling:
%{{{
%closure\_test occurrence -> syntagm, param, pattern
%}}}
%and if not, skip the child.
%Check if `param` can be found already as the parametric description of a child of `pattern`, else create a new child.
%Extends similarly any more general pattern, if possible.**

  * If `param` has been generalised, create a new child with that parametric description.

  * Creates the new occurrence related to that child.

  * Detects new cyclicity.

  * If the occurrence is already cyclic, checks if we arrive in a new start of cycle.

### `pat.memory.learn` (pattern, memory, occurrence -> syntagm) ###

Behavior different if the parametric memory is of type `pat.memostruct` (a combination of elementary memories) or of type `pat.memoparam` (an elementary memory).

> ### `pat.memostruct.learn` (pattern, memory, occurrence -> syntagm) ###

  * Accumulates the memory related to the more specific patterns.
  * Calls `pat.memory.combine` to process the learning phase along the different parametric dimension and combine them together.

> ### `pat.memoparam.learn` (pattern, memory, occurrence -> syntagm) ###

  * Calls `pat.memoparam.find` to detects the syntagm description in the memory hash-table. The results is in the structure `retrieved`.

  * If a previously memorised occurrence is identified as of same parametric description, attempts the creation of a pattern extension by calling:
```
pat.pattern.link (pattern, retrieved, occurrence -> syntagm).
```

  * Else if...

  * Calls recursively `pat.memoparam.learn` for the interval field, and for the more general parametric fields.

### `pat.memory.combine` (pattern, parametric memory, occurrence -> syntagm) ###

  * Calls recursively `learn` to the subfields of the parametric memory, and accumulates the pattern detection results.
  * If the combined pattern detection result is not empty, and is not implied by an already existing pattern extension, calls `pat.pattern.link` for the current pattern, the pattern detection result, and occurrence -> syntagm.

### `pat.pattern.link` (pattern, retrieved, occurrence -> syntagm) ###

Checks if the retrieved occurrence(s) can trigger a new pattern extension.

  * If the retrieved occurrence already terminates to the current note, cancel the whole test.

  * Forbid overlapping of occurrences in a same channel.

  * The parametric description of the extension, `param`, is computed as the common description of the current `syntagm` and the one in `retrieved`. If `param` is not well defined, cancel the whole test. If `param` is already subsumed in a child of `pattern`, return simply that child.

  * Checks if the resulting pattern would be closed by calling:
```
closure_test (occurrence -> syntagm, param, pattern)
```
and if not, cancel the whole test.

  * Extend `pattern` with the new child parametrically defined by `param`.

  * Possibly extend also the more general patterns similarly.

  * Extend all the suitable retrieved occurrences with the new pattern child, leading to an extended occurrence `old_occurrence`, and memorise anyl syntagmatic connection `old_next_syntagm`following it:
```
pat.occurrence.memorize (old_occurrence -> old_next_syntagm)
```

  * Extend the current `occurrence` with the new pattern child.

  * Detect cyclicity.

### closure\_test (occurrence -> syntagm, param, pattern) ###

The extended occurrence (occurrence -> syntagm) is closed if there is no other occurrence `o` ending at the same note that ends the syntagm, such that the parametric description of the last extension of `o` is equal or more specific than `param`.