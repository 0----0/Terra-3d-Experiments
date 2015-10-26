; ModuleID = 'terra'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__fsid_t = type { [2 x i32] }
%struct.__mbstate_t = type { i32, %union.anon }
%union.anon = type { i32 }
%struct._G_fpos_t = type { i64, %struct.__mbstate_t }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct._IO_jump_t = type opaque
%struct._IO_FILE_plus = type opaque
%union.__WAIT_STATUS = type { %union.anon* }
%struct.div_t = type { i32, i32 }
%struct.ldiv_t = type { i64, i64 }
%struct.__sigset_t = type { [16 x i64] }
%union.pthread_attr_t = type { i64, [48 x i8] }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%union.pthread_cond_t = type { %struct.anon.1 }
%struct.anon.1 = type { i32, i32, i64, i64, i64, i8*, i32, i32 }
%union.pthread_rwlock_t = type { %struct.anon.2 }
%struct.anon.2 = type { i32, i32, i32, i32, i32, i32, i32, i32, i8, [7 x i8], i64, i32 }
%union.pthread_rwlockattr_t = type { i64 }
%union.pthread_barrier_t = type { i64, [24 x i8] }
%struct.random_data = type { i32*, i32*, i32*, i32, i32, i32, i32* }
%struct.drand48_data = type { [3 x i16], [3 x i16], i16, i16, i64 }

@stdin = external global %struct._IO_FILE*
@stdout = external global %struct._IO_FILE*
@"$string20" = private unnamed_addr constant [3 x i8] c"%d\00"
@"$string21" = private unnamed_addr constant [4 x i8] c"%d\0A\00"

; Function Attrs: nounwind
define i32 @main() #0 {
entry:
  %x = alloca i32, align 4
  %0 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %1 = load i32* %x, align 4
  %2 = icmp eq i32 %1, 3
  br i1 %2, label %defer1, label %merge

defer1:                                           ; preds = %entry
  %3 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 0

merge:                                            ; preds = %entry
  %4 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %5 = load i32* %x, align 4
  %6 = icmp eq i32 %5, 3
  br i1 %6, label %defer26, label %merge3

defer26:                                          ; preds = %merge
  %7 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %8 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 1

merge3:                                           ; preds = %merge
  %9 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %10 = load i32* %x, align 4
  %11 = icmp eq i32 %10, 3
  br i1 %11, label %defer913, label %merge10

defer913:                                         ; preds = %merge3
  %12 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %13 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %14 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 2

merge10:                                          ; preds = %merge3
  %15 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %16 = load i32* %x, align 4
  %17 = icmp eq i32 %16, 3
  br i1 %17, label %defer1721, label %merge18

defer1721:                                        ; preds = %merge10
  %18 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %19 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %20 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %21 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 3

merge18:                                          ; preds = %merge10
  %22 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %23 = load i32* %x, align 4
  %24 = icmp eq i32 %23, 3
  br i1 %24, label %defer2731, label %merge28

defer2731:                                        ; preds = %merge18
  %25 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %26 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %27 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %28 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %29 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 4

merge28:                                          ; preds = %merge18
  %30 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %31 = load i32* %x, align 4
  %32 = icmp eq i32 %31, 3
  br i1 %32, label %defer3741, label %merge38

defer3741:                                        ; preds = %merge28
  %33 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %34 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %35 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %36 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %37 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %38 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 5

merge38:                                          ; preds = %merge28
  %39 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %40 = load i32* %x, align 4
  %41 = icmp eq i32 %40, 3
  br i1 %41, label %defer4852, label %merge49

defer4852:                                        ; preds = %merge38
  %42 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %43 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %44 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %45 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %46 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %47 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %48 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 6

merge49:                                          ; preds = %merge38
  %49 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %50 = load i32* %x, align 4
  %51 = icmp eq i32 %50, 3
  br i1 %51, label %defer6064, label %merge61

defer6064:                                        ; preds = %merge49
  %52 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %53 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %54 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %55 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %56 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %57 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %58 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %59 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 7

merge61:                                          ; preds = %merge49
  %60 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %61 = load i32* %x, align 4
  %62 = icmp eq i32 %61, 3
  br i1 %62, label %defer7377, label %merge74

defer7377:                                        ; preds = %merge61
  %63 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %64 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %65 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %66 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %67 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %68 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %69 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %70 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %71 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 8

merge74:                                          ; preds = %merge61
  %72 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %73 = load i32* %x, align 4
  %74 = icmp eq i32 %73, 3
  br i1 %74, label %defer8791, label %merge88

defer8791:                                        ; preds = %merge74
  %75 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %76 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %77 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %78 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %79 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %80 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %81 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %82 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %83 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %84 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  ret i32 9

merge88:                                          ; preds = %merge74
  %85 = call i32 (i8*, i32*, ...)* bitcast (i32 (i8*, ...)* @scanf to i32 (i8*, i32*, ...)*)(i8* getelementptr inbounds ([3 x i8]* @"$string20", i64 0, i64 0), i32* %x) #0
  %86 = load i32* %x, align 4
  %87 = icmp eq i32 %86, 3
  %88 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %89 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %90 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %91 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %92 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %93 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %94 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %95 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %96 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %97 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %98 = call i32 (i8*, i32, ...)* bitcast (i32 (i8*, ...)* @printf to i32 (i8*, i32, ...)*)(i8* getelementptr inbounds ([4 x i8]* @"$string21", i64 0, i64 0), i32 3) #0
  %retval = select i1 %87, i32 10, i32 11
  ret i32 %retval
}

; Function Attrs: nounwind readnone
define void @__makeeverythinginclanglive_0(%struct.__fsid_t* nocapture, %struct._IO_FILE* nocapture, %struct.__mbstate_t* nocapture, %union.anon* nocapture, %struct._G_fpos_t* nocapture, %struct._G_fpos_t* nocapture, %struct.__va_list_tag* nocapture, %struct._IO_jump_t* nocapture, %struct._IO_marker* nocapture, %struct._IO_FILE_plus* nocapture, %union.anon* nocapture, %union.anon* nocapture, %union.anon* nocapture, %union.__WAIT_STATUS* nocapture, %struct.div_t* nocapture, %struct.ldiv_t* nocapture, %struct.ldiv_t* nocapture, %struct.__sigset_t* nocapture, %struct.ldiv_t* nocapture, %struct.ldiv_t* nocapture, %struct.__sigset_t* nocapture, %union.pthread_attr_t* nocapture, %struct.__pthread_internal_list* nocapture, %union.pthread_mutex_t* nocapture, %struct.__pthread_mutex_s* nocapture, %union.anon* nocapture, %union.pthread_cond_t* nocapture, %struct.anon.1* nocapture, %union.anon* nocapture, %union.pthread_rwlock_t* nocapture, %struct.anon.2* nocapture, %union.pthread_rwlockattr_t* nocapture, %union.pthread_barrier_t* nocapture, %union.anon* nocapture, %struct.random_data* nocapture, %struct.drand48_data* nocapture) #1 {
  ret void
}

declare i32 @__uflow(%struct._IO_FILE*) #2

declare i32 @__overflow(%struct._IO_FILE*, i32) #2

; Function Attrs: nounwind
declare i32 @_IO_getc(%struct._IO_FILE* nocapture) #3

; Function Attrs: nounwind
declare i32 @_IO_putc(i32, %struct._IO_FILE* nocapture) #3

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: nounwind
declare i32 @vfprintf(%struct._IO_FILE* nocapture, i8* nocapture readonly, %struct.__va_list_tag*) #3

; Function Attrs: inlinehint nounwind
define weak_odr i32 @vprintf(i8* noalias nocapture readonly %__fmt, %struct.__va_list_tag* %__arg) #4 {
  %1 = load %struct._IO_FILE** @stdout, align 8, !tbaa !1
  %2 = tail call i32 @vfprintf(%struct._IO_FILE* %1, i8* %__fmt, %struct.__va_list_tag* %__arg) #0
  ret i32 %2
}

; Function Attrs: nounwind
declare i32 @scanf(i8* nocapture readonly, ...) #3

; Function Attrs: inlinehint nounwind
define weak_odr i32 @getchar() #4 {
  %1 = load %struct._IO_FILE** @stdin, align 8, !tbaa !1
  %2 = tail call i32 @_IO_getc(%struct._IO_FILE* %1) #0
  ret i32 %2
}

; Function Attrs: inlinehint nounwind
define weak_odr i32 @getc_unlocked(%struct._IO_FILE* %__fp) #4 {
  %1 = getelementptr inbounds %struct._IO_FILE* %__fp, i64 0, i32 1
  %2 = load i8** %1, align 8, !tbaa !5
  %3 = getelementptr inbounds %struct._IO_FILE* %__fp, i64 0, i32 2
  %4 = load i8** %3, align 8, !tbaa !10
  %5 = icmp uge i8* %2, %4
  %6 = zext i1 %5 to i64
  %7 = tail call i64 @llvm.expect.i64(i64 %6, i64 0)
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %11, label %9

; <label>:9                                       ; preds = %0
  %10 = tail call i32 @__uflow(%struct._IO_FILE* %__fp) #0
  br label %15

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds i8* %2, i64 1
  store i8* %12, i8** %1, align 8, !tbaa !5
  %13 = load i8* %2, align 1, !tbaa !11
  %14 = zext i8 %13 to i32
  br label %15

; <label>:15                                      ; preds = %11, %9
  %16 = phi i32 [ %10, %9 ], [ %14, %11 ]
  ret i32 %16
}

; Function Attrs: inlinehint nounwind
define weak_odr i32 @getchar_unlocked() #4 {
  %1 = load %struct._IO_FILE** @stdin, align 8, !tbaa !1
  %2 = getelementptr inbounds %struct._IO_FILE* %1, i64 0, i32 1
  %3 = load i8** %2, align 8, !tbaa !5
  %4 = getelementptr inbounds %struct._IO_FILE* %1, i64 0, i32 2
  %5 = load i8** %4, align 8, !tbaa !10
  %6 = icmp uge i8* %3, %5
  %7 = zext i1 %6 to i64
  %8 = tail call i64 @llvm.expect.i64(i64 %7, i64 0)
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10

; <label>:10                                      ; preds = %0
  %11 = tail call i32 @__uflow(%struct._IO_FILE* %1) #0
  br label %16

; <label>:12                                      ; preds = %0
  %13 = getelementptr inbounds i8* %3, i64 1
  store i8* %13, i8** %2, align 8, !tbaa !5
  %14 = load i8* %3, align 1, !tbaa !11
  %15 = zext i8 %14 to i32
  br label %16

; <label>:16                                      ; preds = %12, %10
  %17 = phi i32 [ %11, %10 ], [ %15, %12 ]
  ret i32 %17
}

; Function Attrs: inlinehint nounwind
define weak_odr i32 @fgetc_unlocked(%struct._IO_FILE* %__fp) #4 {
  %1 = getelementptr inbounds %struct._IO_FILE* %__fp, i64 0, i32 1
  %2 = load i8** %1, align 8, !tbaa !5
  %3 = getelementptr inbounds %struct._IO_FILE* %__fp, i64 0, i32 2
  %4 = load i8** %3, align 8, !tbaa !10
  %5 = icmp uge i8* %2, %4
  %6 = zext i1 %5 to i64
  %7 = tail call i64 @llvm.expect.i64(i64 %6, i64 0)
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %11, label %9

; <label>:9                                       ; preds = %0
  %10 = tail call i32 @__uflow(%struct._IO_FILE* %__fp) #0
  br label %15

; <label>:11                                      ; preds = %0
  %12 = getelementptr inbounds i8* %2, i64 1
  store i8* %12, i8** %1, align 8, !tbaa !5
  %13 = load i8* %2, align 1, !tbaa !11
  %14 = zext i8 %13 to i32
  br label %15

; <label>:15                                      ; preds = %11, %9
  %16 = phi i32 [ %10, %9 ], [ %14, %11 ]
  ret i32 %16
}

; Function Attrs: inlinehint nounwind
define weak_odr i32 @putchar(i32 %__c) #4 {
  %1 = load %struct._IO_FILE** @stdout, align 8, !tbaa !1
  %2 = tail call i32 @_IO_putc(i32 %__c, %struct._IO_FILE* %1) #0
  ret i32 %2
}

; Function Attrs: inlinehint nounwind
define weak_odr i32 @fputc_unlocked(i32 %__c, %struct._IO_FILE* %__stream) #4 {
  %1 = getelementptr inbounds %struct._IO_FILE* %__stream, i64 0, i32 5
  %2 = load i8** %1, align 8, !tbaa !12
  %3 = getelementptr inbounds %struct._IO_FILE* %__stream, i64 0, i32 6
  %4 = load i8** %3, align 8, !tbaa !13
  %5 = icmp uge i8* %2, %4
  %6 = zext i1 %5 to i64
  %7 = tail call i64 @llvm.expect.i64(i64 %6, i64 0)
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %12, label %9

; <label>:9                                       ; preds = %0
  %10 = and i32 %__c, 255
  %11 = tail call i32 @__overflow(%struct._IO_FILE* %__stream, i32 %10) #0
  br label %16

; <label>:12                                      ; preds = %0
  %13 = trunc i32 %__c to i8
  %14 = getelementptr inbounds i8* %2, i64 1
  store i8* %14, i8** %1, align 8, !tbaa !12
  store i8 %13, i8* %2, align 1, !tbaa !11
  %15 = and i32 %__c, 255
  br label %16

; <label>:16                                      ; preds = %12, %9
  %17 = phi i32 [ %11, %9 ], [ %15, %12 ]
  ret i32 %17
}

; Function Attrs: inlinehint nounwind
define weak_odr i32 @putc_unlocked(i32 %__c, %struct._IO_FILE* %__stream) #4 {
  %1 = getelementptr inbounds %struct._IO_FILE* %__stream, i64 0, i32 5
  %2 = load i8** %1, align 8, !tbaa !12
  %3 = getelementptr inbounds %struct._IO_FILE* %__stream, i64 0, i32 6
  %4 = load i8** %3, align 8, !tbaa !13
  %5 = icmp uge i8* %2, %4
  %6 = zext i1 %5 to i64
  %7 = tail call i64 @llvm.expect.i64(i64 %6, i64 0)
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %12, label %9

; <label>:9                                       ; preds = %0
  %10 = and i32 %__c, 255
  %11 = tail call i32 @__overflow(%struct._IO_FILE* %__stream, i32 %10) #0
  br label %16

; <label>:12                                      ; preds = %0
  %13 = trunc i32 %__c to i8
  %14 = getelementptr inbounds i8* %2, i64 1
  store i8* %14, i8** %1, align 8, !tbaa !12
  store i8 %13, i8* %2, align 1, !tbaa !11
  %15 = and i32 %__c, 255
  br label %16

; <label>:16                                      ; preds = %12, %9
  %17 = phi i32 [ %11, %9 ], [ %15, %12 ]
  ret i32 %17
}

; Function Attrs: inlinehint nounwind
define weak_odr i32 @putchar_unlocked(i32 %__c) #4 {
  %1 = load %struct._IO_FILE** @stdout, align 8, !tbaa !1
  %2 = getelementptr inbounds %struct._IO_FILE* %1, i64 0, i32 5
  %3 = load i8** %2, align 8, !tbaa !12
  %4 = getelementptr inbounds %struct._IO_FILE* %1, i64 0, i32 6
  %5 = load i8** %4, align 8, !tbaa !13
  %6 = icmp uge i8* %3, %5
  %7 = zext i1 %6 to i64
  %8 = tail call i64 @llvm.expect.i64(i64 %7, i64 0)
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %13, label %10

; <label>:10                                      ; preds = %0
  %11 = and i32 %__c, 255
  %12 = tail call i32 @__overflow(%struct._IO_FILE* %1, i32 %11) #0
  br label %17

; <label>:13                                      ; preds = %0
  %14 = trunc i32 %__c to i8
  %15 = getelementptr inbounds i8* %3, i64 1
  store i8* %15, i8** %2, align 8, !tbaa !12
  store i8 %14, i8* %3, align 1, !tbaa !11
  %16 = and i32 %__c, 255
  br label %17

; <label>:17                                      ; preds = %13, %10
  %18 = phi i32 [ %12, %10 ], [ %16, %13 ]
  ret i32 %18
}

; Function Attrs: inlinehint nounwind readonly
define weak_odr i32 @feof_unlocked(%struct._IO_FILE* nocapture readonly %__stream) #5 {
  %1 = getelementptr inbounds %struct._IO_FILE* %__stream, i64 0, i32 0
  %2 = load i32* %1, align 4, !tbaa !14
  %3 = lshr i32 %2, 4
  %.lobit = and i32 %3, 1
  ret i32 %.lobit
}

; Function Attrs: inlinehint nounwind readonly
define weak_odr i32 @ferror_unlocked(%struct._IO_FILE* nocapture readonly %__stream) #5 {
  %1 = getelementptr inbounds %struct._IO_FILE* %__stream, i64 0, i32 0
  %2 = load i32* %1, align 4, !tbaa !14
  %3 = lshr i32 %2, 5
  %.lobit = and i32 %3, 1
  ret i32 %.lobit
}

; Function Attrs: inlinehint nounwind readonly
define weak_odr double @atof(i8* nocapture nonnull readonly %__nptr) #5 {
  %1 = tail call double @strtod(i8* nocapture %__nptr, i8** null) #0
  ret double %1
}

; Function Attrs: inlinehint nounwind readonly
define weak_odr i32 @atoi(i8* nocapture nonnull readonly %__nptr) #5 {
  %1 = tail call i64 @strtol(i8* nocapture %__nptr, i8** null, i32 10) #0
  %2 = trunc i64 %1 to i32
  ret i32 %2
}

; Function Attrs: inlinehint nounwind readonly
define weak_odr i64 @atol(i8* nocapture nonnull readonly %__nptr) #5 {
  %1 = tail call i64 @strtol(i8* nocapture %__nptr, i8** null, i32 10) #0
  ret i64 %1
}

; Function Attrs: inlinehint nounwind readonly
define weak_odr i64 @atoll(i8* nocapture nonnull readonly %__nptr) #5 {
  %1 = tail call i64 @strtoll(i8* nocapture %__nptr, i8** null, i32 10) #0
  ret i64 %1
}

; Function Attrs: nounwind
declare double @strtod(i8* readonly, i8** nocapture) #3

; Function Attrs: nounwind
declare i64 @strtol(i8* readonly, i8** nocapture, i32) #3

; Function Attrs: nounwind
declare i64 @strtoll(i8* readonly, i8** nocapture, i32) #3

; Function Attrs: inlinehint nounwind readnone
define weak_odr i32 @gnu_dev_major(i64 %__dev) #6 {
  %1 = lshr i64 %__dev, 8
  %2 = and i64 %1, 4095
  %3 = lshr i64 %__dev, 32
  %4 = and i64 %3, 4294963200
  %5 = or i64 %2, %4
  %6 = trunc i64 %5 to i32
  ret i32 %6
}

; Function Attrs: inlinehint nounwind readnone
define weak_odr i32 @gnu_dev_minor(i64 %__dev) #6 {
  %1 = and i64 %__dev, 255
  %2 = lshr i64 %__dev, 12
  %3 = and i64 %2, 4294967040
  %4 = or i64 %3, %1
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

; Function Attrs: inlinehint nounwind readnone
define weak_odr i64 @gnu_dev_makedev(i32 %__major, i32 %__minor) #6 {
  %1 = and i32 %__minor, 255
  %2 = shl i32 %__major, 8
  %3 = and i32 %2, 1048320
  %4 = or i32 %1, %3
  %5 = zext i32 %4 to i64
  %6 = and i32 %__minor, -256
  %7 = zext i32 %6 to i64
  %8 = shl nuw nsw i64 %7, 12
  %9 = and i32 %__major, -4096
  %10 = zext i32 %9 to i64
  %11 = shl nuw i64 %10, 32
  %12 = or i64 %8, %11
  %13 = or i64 %12, %5
  ret i64 %13
}

; Function Attrs: inlinehint nounwind
define weak_odr i8* @bsearch(i8* nonnull %__key, i8* nonnull %__base, i64 %__nmemb, i64 %__size, i32 (i8*, i8*)* nocapture nonnull %__compar) #4 {
  br label %.outer

.outer:                                           ; preds = %11, %0
  %.ph = phi i64 [ %13, %11 ], [ 0, %0 ]
  %.ph1 = phi i64 [ %.lcssa13, %11 ], [ %__nmemb, %0 ]
  br label %1

; <label>:1                                       ; preds = %4, %.outer
  %2 = phi i64 [ %6, %4 ], [ %.ph1, %.outer ]
  %3 = icmp ult i64 %.ph, %2
  br i1 %3, label %4, label %.loopexit.loopexit

; <label>:4                                       ; preds = %1
  %5 = add i64 %2, %.ph
  %6 = lshr i64 %5, 1
  %7 = mul i64 %6, %__size
  %8 = getelementptr inbounds i8* %__base, i64 %7
  %9 = tail call i32 %__compar(i8* %__key, i8* %8) #0
  %10 = icmp slt i32 %9, 0
  br i1 %10, label %1, label %11

; <label>:11                                      ; preds = %4
  %.lcssa15 = phi i32 [ %9, %4 ]
  %.lcssa14 = phi i8* [ %8, %4 ]
  %.lcssa = phi i64 [ %6, %4 ]
  %.lcssa13 = phi i64 [ %2, %4 ]
  %12 = icmp sgt i32 %.lcssa15, 0
  %13 = add nuw i64 %.lcssa, 1
  br i1 %12, label %.outer, label %.loopexit.loopexit12

.loopexit.loopexit:                               ; preds = %1
  br label %.loopexit

.loopexit.loopexit12:                             ; preds = %11
  %.lcssa14.lcssa = phi i8* [ %.lcssa14, %11 ]
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit12, %.loopexit.loopexit
  %14 = phi i8* [ null, %.loopexit.loopexit ], [ %.lcssa14.lcssa, %.loopexit.loopexit12 ]
  ret i8* %14
}

; Function Attrs: nounwind readnone
declare i64 @llvm.expect.i64(i64, i64) #7

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { inlinehint nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { inlinehint nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { inlinehint nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-realign-stack" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.6.2 (tags/RELEASE_362/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"any pointer", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !2, i64 8}
!6 = !{!"_IO_FILE", !7, i64 0, !2, i64 8, !2, i64 16, !2, i64 24, !2, i64 32, !2, i64 40, !2, i64 48, !2, i64 56, !2, i64 64, !2, i64 72, !2, i64 80, !2, i64 88, !2, i64 96, !2, i64 104, !7, i64 112, !7, i64 116, !8, i64 120, !9, i64 128, !3, i64 130, !3, i64 131, !2, i64 136, !8, i64 144, !2, i64 152, !2, i64 160, !2, i64 168, !2, i64 176, !8, i64 184, !7, i64 192, !3, i64 196}
!7 = !{!"int", !3, i64 0}
!8 = !{!"long", !3, i64 0}
!9 = !{!"short", !3, i64 0}
!10 = !{!6, !2, i64 16}
!11 = !{!3, !3, i64 0}
!12 = !{!6, !2, i64 40}
!13 = !{!6, !2, i64 48}
!14 = !{!6, !7, i64 0}
