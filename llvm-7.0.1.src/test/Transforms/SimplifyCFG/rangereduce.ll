; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -simplifycfg -switch-to-lookup -S | FileCheck %s

target datalayout = "e-n32"

define i32 @test1(i32 %a) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[A:%.*]], 97
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = shl i32 [[TMP1]], 30
; CHECK-NEXT:    [[TMP4:%.*]] = or i32 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    switch i32 [[TMP4]], label [[DEF:%.*]] [
; CHECK-NEXT:    i32 0, label [[ONE:%.*]]
; CHECK-NEXT:    i32 1, label [[TWO:%.*]]
; CHECK-NEXT:    i32 2, label [[THREE:%.*]]
; CHECK-NEXT:    i32 3, label [[THREE]]
; CHECK-NEXT:    ]
; CHECK:       def:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i32 [ 8867, [[TMP0:%.*]] ], [ 11984, [[ONE]] ], [ 1143, [[TWO]] ], [ 99783, [[THREE]] ]
; CHECK-NEXT:    ret i32 [[MERGE]]
; CHECK:       one:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       two:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       three:
; CHECK-NEXT:    br label [[DEF]]
;
  switch i32 %a, label %def [
  i32 97, label %one
  i32 101, label %two
  i32 105, label %three
  i32 109, label %three
  ]

def:
  ret i32 8867

one:
  ret i32 11984
two:
  ret i32 1143
three:
  ret i32 99783
}

; Optimization shouldn't trigger; bitwidth > 64
define i128 @test2(i128 %a) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    switch i128 [[A:%.*]], label [[DEF:%.*]] [
; CHECK-NEXT:    i128 97, label [[ONE:%.*]]
; CHECK-NEXT:    i128 101, label [[TWO:%.*]]
; CHECK-NEXT:    i128 105, label [[THREE:%.*]]
; CHECK-NEXT:    i128 109, label [[THREE]]
; CHECK-NEXT:    ]
; CHECK:       def:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i128 [ 8867, [[TMP0:%.*]] ], [ 11984, [[ONE]] ], [ 1143, [[TWO]] ], [ 99783, [[THREE]] ]
; CHECK-NEXT:    ret i128 [[MERGE]]
; CHECK:       one:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       two:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       three:
; CHECK-NEXT:    br label [[DEF]]
;
  switch i128 %a, label %def [
  i128 97, label %one
  i128 101, label %two
  i128 105, label %three
  i128 109, label %three
  ]

def:
  ret i128 8867

one:
  ret i128 11984
two:
  ret i128 1143
three:
  ret i128 99783
}

; Optimization shouldn't trigger; no holes present
define i32 @test3(i32 %a) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    switch i32 [[A:%.*]], label [[DEF:%.*]] [
; CHECK-NEXT:    i32 97, label [[ONE:%.*]]
; CHECK-NEXT:    i32 98, label [[TWO:%.*]]
; CHECK-NEXT:    i32 99, label [[THREE:%.*]]
; CHECK-NEXT:    ]
; CHECK:       def:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i32 [ 8867, [[TMP0:%.*]] ], [ 11984, [[ONE]] ], [ 1143, [[TWO]] ], [ 99783, [[THREE]] ]
; CHECK-NEXT:    ret i32 [[MERGE]]
; CHECK:       one:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       two:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       three:
; CHECK-NEXT:    br label [[DEF]]
;
  switch i32 %a, label %def [
  i32 97, label %one
  i32 98, label %two
  i32 99, label %three
  ]

def:
  ret i32 8867

one:
  ret i32 11984
two:
  ret i32 1143
three:
  ret i32 99783
}

; Optimization shouldn't trigger; not an arithmetic progression
define i32 @test4(i32 %a) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    switch i32 [[A:%.*]], label [[DEF:%.*]] [
; CHECK-NEXT:    i32 97, label [[ONE:%.*]]
; CHECK-NEXT:    i32 102, label [[TWO:%.*]]
; CHECK-NEXT:    i32 105, label [[THREE:%.*]]
; CHECK-NEXT:    i32 109, label [[THREE]]
; CHECK-NEXT:    ]
; CHECK:       def:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i32 [ 8867, [[TMP0:%.*]] ], [ 11984, [[ONE]] ], [ 1143, [[TWO]] ], [ 99783, [[THREE]] ]
; CHECK-NEXT:    ret i32 [[MERGE]]
; CHECK:       one:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       two:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       three:
; CHECK-NEXT:    br label [[DEF]]
;
  switch i32 %a, label %def [
  i32 97, label %one
  i32 102, label %two
  i32 105, label %three
  i32 109, label %three
  ]

def:
  ret i32 8867

one:
  ret i32 11984
two:
  ret i32 1143
three:
  ret i32 99783
}

; Optimization shouldn't trigger; not a power of two
define i32 @test5(i32 %a) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    switch i32 [[A:%.*]], label [[DEF:%.*]] [
; CHECK-NEXT:    i32 97, label [[ONE:%.*]]
; CHECK-NEXT:    i32 102, label [[TWO:%.*]]
; CHECK-NEXT:    i32 107, label [[THREE:%.*]]
; CHECK-NEXT:    i32 112, label [[THREE]]
; CHECK-NEXT:    ]
; CHECK:       def:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i32 [ 8867, [[TMP0:%.*]] ], [ 11984, [[ONE]] ], [ 1143, [[TWO]] ], [ 99783, [[THREE]] ]
; CHECK-NEXT:    ret i32 [[MERGE]]
; CHECK:       one:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       two:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       three:
; CHECK-NEXT:    br label [[DEF]]
;
  switch i32 %a, label %def [
  i32 97, label %one
  i32 102, label %two
  i32 107, label %three
  i32 112, label %three
  ]

def:
  ret i32 8867

one:
  ret i32 11984
two:
  ret i32 1143
three:
  ret i32 99783
}

define i32 @test6(i32 %a) optsize {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[A:%.*]], -109
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = shl i32 [[TMP1]], 30
; CHECK-NEXT:    [[TMP4:%.*]] = or i32 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    switch i32 [[TMP4]], label [[DEF:%.*]] [
; CHECK-NEXT:    i32 3, label [[ONE:%.*]]
; CHECK-NEXT:    i32 2, label [[TWO:%.*]]
; CHECK-NEXT:    i32 1, label [[THREE:%.*]]
; CHECK-NEXT:    i32 0, label [[THREE]]
; CHECK-NEXT:    ]
; CHECK:       def:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i32 [ 8867, [[TMP0:%.*]] ], [ 11984, [[ONE]] ], [ 1143, [[TWO]] ], [ 99783, [[THREE]] ]
; CHECK-NEXT:    ret i32 [[MERGE]]
; CHECK:       one:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       two:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       three:
; CHECK-NEXT:    br label [[DEF]]
;
  switch i32 %a, label %def [
  i32 -97, label %one
  i32 -101, label %two
  i32 -105, label %three
  i32 -109, label %three
  ]

def:
  ret i32 8867

one:
  ret i32 11984
two:
  ret i32 1143
three:
  ret i32 99783
}

define i8 @test7(i8 %a) optsize {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i8 [[A:%.*]], -36
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i8 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = shl i8 [[TMP1]], 6
; CHECK-NEXT:    [[TMP4:%.*]] = or i8 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp ult i8 [[TMP4]], 4
; CHECK-NEXT:    br i1 [[TMP5]], label [[SWITCH_LOOKUP:%.*]], label [[DEF:%.*]]
; CHECK:       switch.lookup:
; CHECK-NEXT:    [[SWITCH_CAST:%.*]] = zext i8 [[TMP4]] to i32
; CHECK-NEXT:    [[SWITCH_SHIFTAMT:%.*]] = mul i32 [[SWITCH_CAST]], 8
; CHECK-NEXT:    [[SWITCH_DOWNSHIFT:%.*]] = lshr i32 -943228976, [[SWITCH_SHIFTAMT]]
; CHECK-NEXT:    [[SWITCH_MASKED:%.*]] = trunc i32 [[SWITCH_DOWNSHIFT]] to i8
; CHECK-NEXT:    ret i8 [[SWITCH_MASKED]]
; CHECK:       def:
; CHECK-NEXT:    ret i8 -93
;
  switch i8 %a, label %def [
  i8 220, label %one
  i8 224, label %two
  i8 228, label %three
  i8 232, label %three
  ]

def:
  ret i8 8867

one:
  ret i8 11984
two:
  ret i8 1143
three:
  ret i8 99783
}

define i32 @test8(i32 %a) optsize {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[A:%.*]], 97
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP1]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = shl i32 [[TMP1]], 30
; CHECK-NEXT:    [[TMP4:%.*]] = or i32 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    switch i32 [[TMP4]], label [[DEF:%.*]] [
; CHECK-NEXT:    i32 0, label [[ONE:%.*]]
; CHECK-NEXT:    i32 1, label [[TWO:%.*]]
; CHECK-NEXT:    i32 2, label [[THREE:%.*]]
; CHECK-NEXT:    i32 4, label [[THREE]]
; CHECK-NEXT:    ]
; CHECK:       def:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i32 [ 8867, [[TMP0:%.*]] ], [ 11984, [[ONE]] ], [ 1143, [[TWO]] ], [ 99783, [[THREE]] ]
; CHECK-NEXT:    ret i32 [[MERGE]]
; CHECK:       one:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       two:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       three:
; CHECK-NEXT:    br label [[DEF]]
;
  switch i32 %a, label %def [
  i32 97, label %one
  i32 101, label %two
  i32 105, label %three
  i32 113, label %three
  ]

def:
  ret i32 8867

one:
  ret i32 11984
two:
  ret i32 1143
three:
  ret i32 99783
}

define i32 @test9(i32 %a) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[A:%.*]], 6
; CHECK-NEXT:    [[TMP2:%.*]] = lshr i32 [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = shl i32 [[TMP1]], 31
; CHECK-NEXT:    [[TMP4:%.*]] = or i32 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    switch i32 [[TMP4]], label [[DEF:%.*]] [
; CHECK-NEXT:    i32 6, label [[ONE:%.*]]
; CHECK-NEXT:    i32 7, label [[TWO:%.*]]
; CHECK-NEXT:    i32 0, label [[THREE:%.*]]
; CHECK-NEXT:    i32 2, label [[THREE]]
; CHECK-NEXT:    ]
; CHECK:       def:
; CHECK-NEXT:    [[MERGE:%.*]] = phi i32 [ 8867, [[TMP0:%.*]] ], [ 11984, [[ONE]] ], [ 1143, [[TWO]] ], [ 99783, [[THREE]] ]
; CHECK-NEXT:    ret i32 [[MERGE]]
; CHECK:       one:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       two:
; CHECK-NEXT:    br label [[DEF]]
; CHECK:       three:
; CHECK-NEXT:    br label [[DEF]]
;
  switch i32 %a, label %def [
  i32 18, label %one
  i32 20, label %two
  i32 6, label %three
  i32 10, label %three
  ]

def:
  ret i32 8867

one:
  ret i32 11984
two:
  ret i32 1143
three:
  ret i32 99783
}

