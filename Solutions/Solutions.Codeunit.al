codeunit 60125 Solutions
{
    procedure AddCommentSeparator(var AllComments: Text[1024]; NewComment: Text[1024]; Separator: Text[10])
    begin
        // The function is supposed to append the NewComment to the AllComments variable and thus return it.
        // The comments are separated by the Separator text.
        // More details can be deducted from the test itself.
        // Implement your solution here.

        if StrLen(AllComments) + StrLen(NewComment) > 1024 then
            exit;

        if StrPos(AllComments, NewComment) > 0 then
            exit;

        if AllComments = '' then begin
            AllComments := NewComment;
            exit;
        end;

        if NewComment = '' then
            exit;

        AllComments := CopyStr(AllComments + Separator + NewComment, 1, 1024);
    end;

    procedure EvaluateDateFromXMLDateTime(var Date: Date; ISO8601DateTime: Text): Boolean
    var
        DT: DateTime;
    begin
        // The function is supposed to extract the date from an ISO 8601 DateTime and return it through the Date variable
        // If a valid date was found, the function returns TRUE otherwise FALSE.
        // More details can be deducted from the test itself.
        // Implement your solution here. You can use the TryDMY2DATE function below.

        if Evaluate(DT, ISO8601DateTime, 9) then begin
            Date := DT2Date(DT);
            exit(Date > 0D);
        end;

        Date := 0D;
        exit(false);
    end;

    procedure EvaluateDateFromXMLDateTimeAlternativeSolution(var Date: Date; ISO8601DateTime: Text[100]): Boolean;
    var
        Day: Integer;
        Month: Integer;
        Year: Integer;
    begin
        if StrLen(ISO8601DateTime) >= 10 then
            if Evaluate(Day, CopyStr(ISO8601DateTime, 9, 2)) then
                if Evaluate(Month, CopyStr(ISO8601DateTime, 6, 2)) then
                    if Evaluate(Year, CopyStr(ISO8601DateTime, 1, 4)) then
                        if TryDMY2DATE(Day, Month, Year, Date) then
                            exit(true);

        Date := 0D;
        exit(false);
    end;

    [TryFunction]
    procedure TryDMY2DATE(Day: Integer; Month: Integer; Year: Integer; var Date: Date)
    begin
        Date := DMY2Date(Day, Month, Year);
    end;

    procedure hex2int(hex: Code[16]) int: BigInteger
    begin
        // The function is supposed to convert a hex number to an integer.
        // More details can be deducted from the test itself.
        // Implement your solution here.

        if StrLen(hex) = 0 then
            exit(0);
        if StrLen(hex) = 1 then
            case hex of
                '0' .. '9':
                    begin
                        Evaluate(int, hex);
                        exit(int);
                    end;
                'A':
                    exit(10);
                'B':
                    exit(11);
                'C':
                    exit(12);
                'D':
                    exit(13);
                'E':
                    exit(14);
                'F':
                    exit(15);
            end;

        exit(hex2int(CopyStr(hex, 1, StrLen(hex) - 1)) * 16 + hex2int(CopyStr(hex, StrLen(hex), 1)));
    end;

    procedure int2hex(int: BigInteger) hex: Code[16]
    begin
        // The function is supposed to convert an integer to hexadecimal.
        // More details can be deducted from the test itself.
        // Implement your solution here.

        if int < 0 then
            exit('');
        if int < 16 then
            case int of
                0 .. 9:
                    exit(Format(int));
                10:
                    exit('A');
                11:
                    exit('B');
                12:
                    exit('C');
                13:
                    exit('D');
                14:
                    exit('E');
                15:
                    exit('F');
            end;

        exit(CopyStr(int2hex(int div 16) + int2hex(int mod 16), 1, 16));
    end;
}
