
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for time slots'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_TIME_SLOTS 
  as select from I_Language
{
  key cast('080000' as abap.tims) as TimeSlot 
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('083000' as abap.tims) as TimeSlot 
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('090000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('093000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('100000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('103000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('110000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('113000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('120000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('123000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('130000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('133000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('140000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('143000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('150000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('153000' as abap.tims) as TimeSlot
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('160000' as abap.tims) as TimeSlot
 
} where I_Language.Language = 'E'

union all select from I_Language
{
  key cast('163000' as abap.tims) as TimeSlot
  
} where I_Language.Language = 'E'

