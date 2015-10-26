; ModuleID = 'defertestcpp.cpp'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type <{ i32 (...)**, i32, [4 x i8] }>
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type <{ %"class.std::locale::facet.base", [4 x i8], %struct.__locale_struct*, i8, [7 x i8], i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8, [6 x i8] }>
%"class.std::locale::facet.base" = type <{ i32 (...)**, i32 }>
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet.base", [4 x i8] }
%"class.std::num_get" = type { %"class.std::locale::facet.base", [4 x i8] }
%class._DeferredPrint = type { i32 }
%class._DeferredPrint.0 = type { i8* }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"lol\00", align 1
@.str2 = private unnamed_addr constant [3 x i8] c"no\00", align 1
@.str3 = private unnamed_addr constant [3 x i8] c"ay\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_defertestcpp.cpp, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #1

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #2

; Function Attrs: nounwind uwtable
define i32 @main() #3 {
  %x = alloca i32, align 4
  %a = alloca %class._DeferredPrint, align 4
  %b = alloca %class._DeferredPrint.0, align 8
  %e = alloca %class._DeferredPrint.0, align 8
  %c = alloca %class._DeferredPrint.0, align 8
  %d = alloca %class._DeferredPrint, align 4
  %1 = call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i32* %x)
  %2 = getelementptr inbounds %class._DeferredPrint* %a, i64 0, i32 0
  store i32 3, i32* %2, align 4, !tbaa !1, !alias.scope !6
  %3 = load i32* %x, align 4, !tbaa !9
  %4 = icmp eq i32 %3, 3
  br i1 %4, label %5, label %12

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([3 x i8]* @.str, i64 0, i64 0), i32* %x)
  %7 = getelementptr inbounds %class._DeferredPrint.0* %b, i64 0, i32 0
  store i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i8** %7, align 8, !tbaa !10, !alias.scope !13
  %8 = getelementptr inbounds %class._DeferredPrint.0* %e, i64 0, i32 0
  store i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i8** %8, align 8, !tbaa !10, !alias.scope !16
  %9 = load i32* %x, align 4, !tbaa !9
  switch i32 %9, label %.thread2 [
    i32 4, label %.thread
    i32 5, label %11
  ]

.thread:                                          ; preds = %5
  call void @_ZN14_DeferredPrintIPKcED2Ev(%class._DeferredPrint.0* %e) #2
  call void @_ZN14_DeferredPrintIPKcED2Ev(%class._DeferredPrint.0* %b) #2
  br label %16

.thread2:                                         ; preds = %5
  %10 = getelementptr inbounds %class._DeferredPrint.0* %c, i64 0, i32 0
  store i8* getelementptr inbounds ([3 x i8]* @.str2, i64 0, i64 0), i8** %10, align 8, !tbaa !10, !alias.scope !19
  call void @_ZN14_DeferredPrintIPKcED2Ev(%class._DeferredPrint.0* %c) #2
  call void @_ZN14_DeferredPrintIPKcED2Ev(%class._DeferredPrint.0* %e) #2
  call void @_ZN14_DeferredPrintIPKcED2Ev(%class._DeferredPrint.0* %b) #2
  br label %12

; <label>:11                                      ; preds = %5
  call void @_ZN14_DeferredPrintIPKcED2Ev(%class._DeferredPrint.0* %e) #2
  call void @_ZN14_DeferredPrintIPKcED2Ev(%class._DeferredPrint.0* %b) #2
  br label %14

; <label>:12                                      ; preds = %.thread2, %0
  %13 = call i32 @puts(i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0))
  br label %14

; <label>:14                                      ; preds = %11, %12
  %15 = getelementptr inbounds %class._DeferredPrint* %d, i64 0, i32 0
  store i32 4, i32* %15, align 4, !tbaa !1, !alias.scope !22
  call void @_ZN14_DeferredPrintIiED2Ev(%class._DeferredPrint* %d) #2
  br label %16

; <label>:16                                      ; preds = %.thread, %14
  call void @_ZN14_DeferredPrintIiED2Ev(%class._DeferredPrint* %a) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @scanf(i8* nocapture readonly, ...) #1

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #4 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #2
  tail call void @_ZSt9terminatev() #7
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZN14_DeferredPrintIPKcED2Ev(%class._DeferredPrint.0* nocapture readonly %this) unnamed_addr #3 align 2 {
  %1 = getelementptr inbounds %class._DeferredPrint.0* %this, i64 0, i32 0
  %2 = load i8** %1, align 8, !tbaa !10
  %3 = icmp eq i8* %2, null
  br i1 %3, label %4, label %15

; <label>:4                                       ; preds = %0
  %5 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !25
  %6 = getelementptr i8* %5, i64 -24
  %7 = bitcast i8* %6 to i64*
  %8 = load i64* %7, align 8
  %9 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %8
  %10 = bitcast i8* %9 to %"class.std::basic_ios"*
  %.sum.i = add i64 %8, 32
  %11 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i
  %12 = bitcast i8* %11 to i32*
  %13 = load i32* %12, align 4, !tbaa !27
  %14 = or i32 %13, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %10, i32 %14)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %41

; <label>:15                                      ; preds = %0
  %16 = tail call i64 @strlen(i8* %2) #2
  %17 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* dereferenceable(272) @_ZSt4cout, i8* %2, i64 %16)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %41

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %4, %15
  %18 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !25
  %19 = getelementptr i8* %18, i64 -24
  %20 = bitcast i8* %19 to i64*
  %21 = load i64* %20, align 8
  %.sum = add i64 %21, 240
  %22 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %23 = bitcast i8* %22 to %"class.std::ctype"**
  %24 = load %"class.std::ctype"** %23, align 8, !tbaa !34
  %25 = icmp eq %"class.std::ctype"* %24, null
  br i1 %25, label %26, label %.noexc7

; <label>:26                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc11 unwind label %41

.noexc11:                                         ; preds = %26
  unreachable

.noexc7:                                          ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %27 = getelementptr inbounds %"class.std::ctype"* %24, i64 0, i32 8
  %28 = load i8* %27, align 1, !tbaa !37
  %29 = icmp eq i8 %28, 0
  br i1 %29, label %33, label %30

; <label>:30                                      ; preds = %.noexc7
  %31 = getelementptr inbounds %"class.std::ctype"* %24, i64 0, i32 9, i64 10
  %32 = load i8* %31, align 1, !tbaa !39
  br label %.noexc3

; <label>:33                                      ; preds = %.noexc7
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %24)
          to label %.noexc9 unwind label %41

.noexc9:                                          ; preds = %33
  %34 = bitcast %"class.std::ctype"* %24 to i8 (%"class.std::ctype"*, i8)***
  %35 = load i8 (%"class.std::ctype"*, i8)*** %34, align 8, !tbaa !25
  %36 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %35, i64 6
  %37 = load i8 (%"class.std::ctype"*, i8)** %36, align 8
  %38 = invoke signext i8 %37(%"class.std::ctype"* %24, i8 signext 10)
          to label %.noexc3 unwind label %41

.noexc3:                                          ; preds = %.noexc9, %30
  %.0.i = phi i8 [ %32, %30 ], [ %38, %.noexc9 ]
  %39 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc4 unwind label %41

.noexc4:                                          ; preds = %.noexc3
  %40 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %39)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %41

_ZNSolsEPFRSoS_E.exit:                            ; preds = %.noexc4
  ret void

; <label>:41                                      ; preds = %26, %.noexc9, %33, %.noexc4, %.noexc3, %15, %4
  %42 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %43 = extractvalue { i8*, i32 } %42, 0
  tail call void @__clang_call_terminate(i8* %43) #7
  unreachable
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZN14_DeferredPrintIiED2Ev(%class._DeferredPrint* nocapture readonly %this) unnamed_addr #3 align 2 {
  %1 = getelementptr inbounds %class._DeferredPrint* %this, i64 0, i32 0
  %2 = load i32* %1, align 4, !tbaa !1
  %3 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %2)
          to label %4 unwind label %30

; <label>:4                                       ; preds = %0
  %5 = bitcast %"class.std::basic_ostream"* %3 to i8**
  %6 = load i8** %5, align 8, !tbaa !25
  %7 = getelementptr i8* %6, i64 -24
  %8 = bitcast i8* %7 to i64*
  %9 = load i64* %8, align 8
  %10 = bitcast %"class.std::basic_ostream"* %3 to i8*
  %.sum = add i64 %9, 240
  %11 = getelementptr inbounds i8* %10, i64 %.sum
  %12 = bitcast i8* %11 to %"class.std::ctype"**
  %13 = load %"class.std::ctype"** %12, align 8, !tbaa !34
  %14 = icmp eq %"class.std::ctype"* %13, null
  br i1 %14, label %15, label %.noexc4

; <label>:15                                      ; preds = %4
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc8 unwind label %30

.noexc8:                                          ; preds = %15
  unreachable

.noexc4:                                          ; preds = %4
  %16 = getelementptr inbounds %"class.std::ctype"* %13, i64 0, i32 8
  %17 = load i8* %16, align 1, !tbaa !37
  %18 = icmp eq i8 %17, 0
  br i1 %18, label %22, label %19

; <label>:19                                      ; preds = %.noexc4
  %20 = getelementptr inbounds %"class.std::ctype"* %13, i64 0, i32 9, i64 10
  %21 = load i8* %20, align 1, !tbaa !39
  br label %.noexc

; <label>:22                                      ; preds = %.noexc4
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %13)
          to label %.noexc6 unwind label %30

.noexc6:                                          ; preds = %22
  %23 = bitcast %"class.std::ctype"* %13 to i8 (%"class.std::ctype"*, i8)***
  %24 = load i8 (%"class.std::ctype"*, i8)*** %23, align 8, !tbaa !25
  %25 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %24, i64 6
  %26 = load i8 (%"class.std::ctype"*, i8)** %25, align 8
  %27 = invoke signext i8 %26(%"class.std::ctype"* %13, i8 signext 10)
          to label %.noexc unwind label %30

.noexc:                                           ; preds = %.noexc6, %19
  %.0.i = phi i8 [ %21, %19 ], [ %27, %.noexc6 ]
  %28 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %3, i8 signext %.0.i)
          to label %.noexc1 unwind label %30

.noexc1:                                          ; preds = %.noexc
  %29 = invoke dereferenceable(272) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %28)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %30

_ZNSolsEPFRSoS_E.exit:                            ; preds = %.noexc1
  ret void

; <label>:30                                      ; preds = %15, %.noexc6, %22, %.noexc1, %.noexc, %0
  %31 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %32 = extractvalue { i8*, i32 } %31, 0
  tail call void @__clang_call_terminate(i8* %32) #7
  unreachable
}

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #5

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* dereferenceable(272), i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #6

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

declare dereferenceable(272) %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"*, i32) #0

define internal void @_GLOBAL__sub_I_defertestcpp.cpp() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #2
  ret void
}

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline noreturn nounwind }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn nounwind }
attributes #8 = { noreturn }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.6.2 (tags/RELEASE_362/final)"}
!1 = !{!2, !3, i64 0}
!2 = !{!"_ZTS14_DeferredPrintIiE", !3, i64 0}
!3 = !{!"int", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_Z13DeferredPrintIiE14_DeferredPrintIT_ES1_: %agg.result"}
!8 = distinct !{!8, !"_Z13DeferredPrintIiE14_DeferredPrintIT_ES1_"}
!9 = !{!3, !3, i64 0}
!10 = !{!11, !12, i64 0}
!11 = !{!"_ZTS14_DeferredPrintIPKcE", !12, i64 0}
!12 = !{!"any pointer", !4, i64 0}
!13 = !{!14}
!14 = distinct !{!14, !15, !"_Z13DeferredPrintIPKcE14_DeferredPrintIT_ES3_: %agg.result"}
!15 = distinct !{!15, !"_Z13DeferredPrintIPKcE14_DeferredPrintIT_ES3_"}
!16 = !{!17}
!17 = distinct !{!17, !18, !"_Z13DeferredPrintIPKcE14_DeferredPrintIT_ES3_: %agg.result"}
!18 = distinct !{!18, !"_Z13DeferredPrintIPKcE14_DeferredPrintIT_ES3_"}
!19 = !{!20}
!20 = distinct !{!20, !21, !"_Z13DeferredPrintIPKcE14_DeferredPrintIT_ES3_: %agg.result"}
!21 = distinct !{!21, !"_Z13DeferredPrintIPKcE14_DeferredPrintIT_ES3_"}
!22 = !{!23}
!23 = distinct !{!23, !24, !"_Z13DeferredPrintIiE14_DeferredPrintIT_ES1_: %agg.result"}
!24 = distinct !{!24, !"_Z13DeferredPrintIiE14_DeferredPrintIT_ES1_"}
!25 = !{!26, !26, i64 0}
!26 = !{!"vtable pointer", !5, i64 0}
!27 = !{!28, !31, i64 32}
!28 = !{!"_ZTSSt8ios_base", !29, i64 8, !29, i64 16, !30, i64 24, !31, i64 28, !31, i64 32, !12, i64 40, !32, i64 48, !4, i64 64, !3, i64 192, !12, i64 200, !33, i64 208}
!29 = !{!"long", !4, i64 0}
!30 = !{!"_ZTSSt13_Ios_Fmtflags", !4, i64 0}
!31 = !{!"_ZTSSt12_Ios_Iostate", !4, i64 0}
!32 = !{!"_ZTSNSt8ios_base6_WordsE", !12, i64 0, !29, i64 8}
!33 = !{!"_ZTSSt6locale", !12, i64 0}
!34 = !{!35, !12, i64 240}
!35 = !{!"_ZTSSt9basic_iosIcSt11char_traitsIcEE", !12, i64 216, !4, i64 224, !36, i64 225, !12, i64 232, !12, i64 240, !12, i64 248, !12, i64 256}
!36 = !{!"bool", !4, i64 0}
!37 = !{!38, !4, i64 56}
!38 = !{!"_ZTSSt5ctypeIcE", !12, i64 16, !36, i64 24, !12, i64 32, !12, i64 40, !12, i64 48, !4, i64 56, !4, i64 57, !4, i64 313, !4, i64 569}
!39 = !{!4, !4, i64 0}
