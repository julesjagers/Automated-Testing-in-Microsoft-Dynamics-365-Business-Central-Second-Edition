codeunit 80022 "LookupValue Copy Document"
{
    //[FEATURE] LookupValue UT Copy Document
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure CopyDocumentWithLookupValueIntoSalesOrder()
    var
        DocumentNo: Code[20];
        NewSalesOrderNo: Code[20];
        LookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0001] Copy sales order with lookup value to new sales order without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] Sales order with lookup value.
        DocumentNo := CreateDocumentWithLookupValue("Sales Document Type"::Order, LookupValueCode);
        //[GIVEN] Sales order without lookup value.
        NewSalesOrderNo := CreateDocumentWithoutLookupValue("Sales Document Type"::Order);

        //[WHEN] Copy sales order in sales order.
        CopyDocumentIntoSalesHeader(DocumentNo, NewSalesOrderNo, "Sales Document Type"::Order, "Sales Document Type From"::Order);

        //[THEN] Sales order has lookup value equal to lookup value from copied document.
        VerifySalesOrderHasLookUpValue(DocumentNo, NewSalesOrderNo, "Sales Document Type"::Order);
    end;

    [Test]
    procedure CopyDocumentWithLookupValueIntoSalesOrderWithLookupValue()
    var
        DocumentNo: Code[20];
        SalesOrderNo: Code[20];
        LookupCode: Code[20];
        NewLookupCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0002] Copy document with lookup value to sales order with lookup value.
        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupCode := CreateLookupValueCode();
        NewLookupCode := CreateLookupValueCode();

        //[GIVEN] Document with lookup value.
        DocumentNo := CreateDocumentWithLookupValue("Sales Document Type"::Order, LookupCode);
        //[GIVEN] Sales order with lookup value.
        SalesOrderNo := CreateDocumentWithLookupValue("Sales Document Type"::Order, NewLookupCode);
        //[WHEN] Copy document in sales order.
        CopyDocumentIntoSalesHeader(DocumentNo, SalesOrderNo, "Sales Document Type"::Order, "Sales Document Type From"::Order);
        //[THEN] Sales order has lookup value equal to lookup value from copied document.
        VerifySalesOrderHasLookUpValue(DocumentNo, SalesOrderNo, "Sales Document Type"::Order);
    end;

    [Test]
    procedure CopyDocumentWithoutLookupValueIntoSalesOrderWithLookupValue()
    var
        DocumentNo: Code[20];
        SalesOrderNo: Code[20];
        LookupCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0003] Copy document without lookup value to sales order with lookup value.
        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupCode := CreateLookupValueCode();
        //[GIVEN] Document without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::Order);
        //[GIVEN] Sales order with lookup value.
        SalesOrderNo := CreateDocumentWithLookupValue("Sales Document Type"::Order, LookupCode);
        //[WHEN] Copy document in sales order.
        CopyDocumentIntoSalesHeader(DocumentNo, SalesOrderNo, "Sales Document Type"::Order, "Sales Document Type From"::Order);
        //[THEN] Sales order has lookup value equal to lookup value from copied document.
        VerifySalesOrderHasLookUpValue(DocumentNo, SalesOrderNo, "Sales Document Type"::Order);
    end;

    [Test]
    procedure CopyDocumentWithLookupValueIntoQuoteSalesWithoutLookupValue()
    var
        DocumentNo: Code[20];
        QuoteSalesNo: Code[20];
        LookupCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0004] Copy document with lookup value to quote sale without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with quote order numbers
        CreateSalesSetupWithQuoteNos(SerieNumber);
        //[GIVEN] Sales & Receivable setup with return order numbers
        CreateSalesSetupWithReturnOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupCode := CreateLookupValueCode();
        //[GIVEN] Document without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::Quote);
        //[GIVEN] Sales quote with lookup value.
        QuoteSalesNo := CreateDocumentWithLookupValue("Sales Document Type"::Quote, LookupCode);
        //[WHEN] Copy document in sales quote.
        CopyDocumentIntoSalesHeader(DocumentNo, QuoteSalesNo, "Sales Document Type"::Quote, "Sales Document Type From"::Quote);
        //[THEN] Sales quote has lookup value equal to lookup value from copied document.
        VerifySalesOrderHasLookUpValue(DocumentNo, QuoteSalesNo, "Sales Document Type"::Quote);
    end;

    [Test]
    procedure CopyDocumentWithLookupValueIntoInvoiceSalesWithoutLookupValue()
    var
        DocumentNo: Code[20];
        InvoiceSaleNo: Code[20];
        LookupCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with invoice numbers
        CreateSalesSetupWithInvoiceNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupCode := CreateLookupValueCode();
        //[GIVEN] Document without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::Invoice);
        //[GIVEN] Sales invoice document with lookup value.
        InvoiceSaleNo := CreateDocumentWithLookupValue("Sales Document Type"::Invoice, LookupCode);
        //[WHEN] Copy document in sales ord.
        CopyDocumentIntoSalesHeader(DocumentNo, InvoiceSaleNo, "Sales Document Type"::Invoice, "Sales Document Type From"::Invoice);
        //[THEN] Sales quote has lookup value equal to lookup value from copied document.
        VerifySalesOrderHasLookUpValue(DocumentNo, InvoiceSaleNo, "Sales Document Type"::Invoice);
    end;

    [Test]
    procedure CopyDocumentWithLookupValueIntoBlanketSalesWithoutLookupValue()
    var
        SalesHeader: Record "Sales Header";
        DocumentNo: Code[20];
        BlanketSalesNo: Code[20];
        LookupCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithBlanketOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupCode := CreateLookupValueCode();
        //[GIVEN] Document without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::"Blanket Order");
        //[GIVEN] Sales invoice document with lookup value.
        BlanketSalesNo := CreateDocumentWithLookupValue("Sales Document Type"::"Blanket Order", LookupCode);
        //[WHEN] Copy document in sales ord.
        CopyDocumentIntoSalesHeader(DocumentNo, BlanketSalesNo, "Sales Document Type"::"Blanket Order", "Sales Document Type From"::"Blanket Order");
        //[THEN] Sales quote has lookup value equal to lookup value from copied document.
        VerifySalesOrderHasLookUpValue(DocumentNo, BlanketSalesNo, "Sales Document Type"::"Blanket Order");
    end;

    [Test]
    procedure CopyDocumentWithLookupValueIntoReturnOrderWithoutLookupValue()
    var
        SalesHeader: Record "Sales Header";
        DocumentNo: Code[20];
        ReturnOrderNo: Code[20];
        LookupCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithReturnOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupCode := CreateLookupValueCode();
        //[GIVEN] Document without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::"Return Order");
        //[GIVEN] Sales invoice document with lookup value.
        ReturnOrderNo := CreateDocumentWithLookupValue("Sales Document Type"::"Return Order", LookupCode);
        //[WHEN] Copy document in sales ord.
        CopyDocumentIntoSalesHeader(DocumentNo, ReturnOrderNo, "Sales Document Type"::"Return Order", "Sales Document Type From"::"Return Order");
        //[THEN] Sales quote has lookup value equal to lookup value from copied document.
        VerifySalesOrderHasLookUpValue(DocumentNo, ReturnOrderNo, "Sales Document Type"::"Return Order");
    end;

    local procedure CreateDocumentWithLookupValue(DocumentType: Enum "Sales Document Type"; LookupCode: Code[20]): Code[20]
    var
        LibrarySales: Codeunit "Library - Sales";
        SalesHeader: Record "Sales Header";
    begin
        //LibrarySales.CreateSalesHeader(SalesHeader, DocumentType, '');
        SalesHeader.Validate("Document Type", DocumentType);
        SalesHeader.Insert(true);
        SalesHeader.Validate("Lookup Value Code", LookupCode);
        SalesHeader.Modify();
        exit(SalesHeader."No.");
    end;

    local procedure CreateSalesSetupWithOrderNos(NumberSeries: Code[20]): Code[20];
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NumberOfSeries: Record "No. Series";

    begin
        NumberOfSeries.Get(NumberSeries);
        if not SalesSetup.FindFirst() then begin
            SalesSetup.Init();
            SalesSetup."Primary Key" := RandomCode10();
            SalesSetup.Insert(true);
        end;

        SalesSetup."Order Nos." := NumberOfSeries.Code;
        SalesSetup.Modify(true);
        exit(SalesSetup."Primary Key");
    end;

    local procedure CreateSalesSetupWithQuoteNos(NumberSeries: Code[20]): Code[20];
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NumberOfSeries: Record "No. Series";

    begin
        NumberOfSeries.Get(NumberSeries);
        if not SalesSetup.FindFirst() then begin
            SalesSetup.Init();
            SalesSetup."Primary Key" := RandomCode10();
            SalesSetup.Insert(true);
        end;

        SalesSetup."Quote Nos." := NumberOfSeries.Code;
        SalesSetup.Modify(true);
        exit(SalesSetup."Primary Key");
    end;

    local procedure CreateSalesSetupWithInvoiceNos(NumberSeries: Code[20]): Code[20];
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NumberOfSeries: Record "No. Series";

    begin
        NumberOfSeries.Get(NumberSeries);
        if not SalesSetup.FindFirst() then begin
            SalesSetup.Init();
            SalesSetup."Primary Key" := RandomCode10();
            SalesSetup.Insert(true);
        end;

        SalesSetup."Invoice Nos." := NumberOfSeries.Code;
        SalesSetup."Posted Invoice Nos." := NumberOfSeries.Code;
        SalesSetup.Modify(true);
        exit(SalesSetup."Primary Key");
    end;

    local procedure CreateSalesSetupWithBlanketOrderNos(NumberSeries: Code[20]): Code[20];
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NumberOfSeries: Record "No. Series";

    begin
        NumberOfSeries.Get(NumberSeries);
        if not SalesSetup.FindFirst() then begin
            SalesSetup.Init();
            SalesSetup."Primary Key" := RandomCode10();
            SalesSetup.Insert(true);
        end;

        SalesSetup."Blanket Order Nos." := NumberOfSeries.Code;
        SalesSetup.Modify(true);
        exit(SalesSetup."Primary Key");
    end;

    local procedure CreateSalesSetupWithReturnOrderNos(NumberSeries: Code[20]): Code[20];
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NumberOfSeries: Record "No. Series";

    begin
        NumberOfSeries.Get(NumberSeries);
        if not SalesSetup.FindFirst() then begin
            SalesSetup.Init();
            SalesSetup."Primary Key" := RandomCode10();
            SalesSetup.Insert(true);
        end;

        SalesSetup."Return Order Nos." := NumberOfSeries.Code;
        SalesSetup.Modify(true);
        exit(SalesSetup."Primary Key");
    end;

    local procedure RandomCode10(): Code[10];
    begin
        exit(Format(Random(999999999)));
    end;

    local procedure CreateNoSeries(): Code[20];
    var
        NumberSeries: Record "No. Series";
        NumberOfSeriesLine: Record "No. Series Line";
    begin
        if not NumberSeries.FindFirst() then begin
            NumberSeries.Init();
            NumberSeries.Code := 'Test - Code';
            NumberSeries.Description := 'Test - Codes';
            NumberSeries."Default Nos." := true;
            NumberSeries."Manual Nos." := false;
            NumberSeries.Insert(true);

            NumberOfSeriesLine.Init();
            NumberOfSeriesLine."Series Code" := NumberSeries.Code;
            NumberOfSeriesLine."Starting Date" := 0D;
            NumberOfSeriesLine."Starting No." := 'Code00001';
            NumberOfSeriesLine."Increment-by No." := 1;
            NumberOfSeriesLine.Insert();
        end;
        exit(NumberSeries.Code);
    end;

    local procedure CreateDocumentWithoutLookupValue(DocumentType: Enum "Sales Document Type"): Code[20]
    var
        LibrarySales: Codeunit "Library - Sales";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Validate("Document Type", DocumentType);
        SalesHeader.Insert(true);
        exit(SalesHeader."No.");
    end;

    local procedure CopyDocumentIntoSalesHeader(DocumentNo: Code[20]; NewSalesHeaderNo: Code[20]; SalesHeaderDocType: Enum "Sales Document Type"; DocumentType: Enum "Sales Document Type From")
    var
        CopyManager: Codeunit "Copy Document Mgt.";
        OldSalesHeader: Record "Sales Header";
        NewSalesHeader: Record "Sales Header";
    begin
        OldSalesHeader.Get(SalesHeaderDocType, DocumentNo);
        NewSalesHeader.Get(SalesHeaderDocType, NewSalesHeaderNo);
        CopyManager.SetProperties(true, false, false, false, true, false, true);
        CopyManager.CopySalesDoc(DocumentType, DocumentNo, NewSalesHeader);
    end;

    local procedure CreateLookupValueCode(): Code[10]
    var
        LibraryLookupValue: Codeunit "Library - Lookup Value";
    begin
        exit(LibraryLookupValue.CreateLookupValueCode())
    end;

    local procedure VerifySalesOrderHasLookUpValue(DocumentNo: Code[20]; NewSalesHeaderNo: Code[20]; DocumentType: enum "Sales Document Type")
    var
        OldSalesHeader: Record "Sales Header";
        NewSalesHeader: Record "Sales Header";
    begin
        OldSalesHeader.Get(DocumentType, DocumentNo);
        NewSalesHeader.Get(DocumentType, NewSalesHeaderNo);
        Assert.AreEqual(OldSalesHeader."Lookup Value Code", NewSalesHeader."Lookup Value Code", NewSalesHeader.FieldCaption("Lookup Value Code"));
    end;

}