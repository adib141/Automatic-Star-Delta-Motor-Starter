PROGRAM main
  VAR
    stop : BOOL;
    start : BOOL;
    motor_run : BOOL;
    star : BOOL;
    TON0 : TON;
    delta : BOOL;
    TON1 : TON;
    overload : BOOL;
    red_lamp : BOOL;
  END_VAR

  motor_run := (motor_run OR start) AND NOT(overload) AND NOT(stop);
  star := NOT(overload) AND NOT(TON0.Q) AND motor_run;
  TON0(IN := motor_run, PT := T#5s);
  delta := NOT(overload) AND NOT(star) AND TON1.Q AND motor_run;
  TON1(IN := TON0.Q, PT := T#500ms);
  red_lamp := overload;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 1);
    PROGRAM instance0 WITH task0 : main;
  END_RESOURCE
END_CONFIGURATION
