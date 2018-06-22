module Msg exposing ( Msg(..) )

import Date exposing (Date)


-- UPDATE
type Msg = NoOp
        | Name String
        | Surname String
        | Birthday Date
        | Telephone String
        | Email String
        | AcceptCompanyRules

