codeunit 80022 "LookupValue Copy Document"
{
    //[FEATURE] LookupValue UT Copy Document
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";

    [Test]
    procedure CopySalesOrderWithLookupValueIntoSalesOrderWithoutLookupValue()
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
        //[GIVEN] Sales order with lookup value (Copy from).
        DocumentNo := CreateDocumentWithLookupValue("Sales Document Type"::Order, LookupValueCode);
        //[GIVEN] sales order without lookup value (Copy to).
        NewSalesOrderNo := CreateDocumentWithoutLookupValue("Sales Document Type"::Order);

        //[WHEN] Copy sales order in new sales order.
        CopyDocumentIntoSalesHeader(DocumentNo, NewSalesOrderNo, "Sales Document Type"::Order, "Sales Document Type From"::Order);

        //[THEN] Sales order has lookup value equal to lookup value from copied document.
        VerifySalesHeaderHasLookUpValue(DocumentNo, NewSalesOrderNo, "Sales Document Type"::Order);
    end;

    [Test]
    procedure CopySalesOrderWithLookupValueIntoSalesOrderWithNewLookupValue()
    var
        DocumentNo: Code[20];
        NewSalesOrderNo: Code[20];
        LookupValueCode: Code[20];
        NewLookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0002] Copy sales order with lookup value to sales order with new lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] New lookup value
        NewLookupValueCode := CreateLookupValueCode();
        //[GIVEN] Sales order with lookup value.
        DocumentNo := CreateDocumentWithLookupValue("Sales Document Type"::Order, LookupValueCode);
        //[GIVEN] Sales order with lookup value.
        NewSalesOrderNo := CreateDocumentWithLookupValue("Sales Document Type"::Order, NewLookupValueCode);

        //[WHEN] Copy Sales order in new sales order.
        CopyDocumentIntoSalesHeader(DocumentNo, NewSalesOrderNo, "Sales Document Type"::Order, "Sales Document Type From"::Order);

        //[THEN] New sales order has lookup value equal to lookup value from copied document.
        VerifySalesHeaderHasLookUpValue(DocumentNo, NewSalesOrderNo, "Sales Document Type"::Order);
    end;

    [Test]
    procedure CopySalesOrderWithoutLookupValueIntoSalesOrderWithLookupValue()
    var
        DocumentNo: Code[20];
        NewSalesOrderNo: Code[20];
        LookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0003] Copy sales order without lookup value to new sales order with lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] Document without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::Order);
        //[GIVEN] Sales order with lookup value.
        NewSalesOrderNo := CreateDocumentWithLookupValue("Sales Document Type"::Order, LookupValueCode);
        //[WHEN] Copy document in sales order.
        CopyDocumentIntoSalesHeader(DocumentNo, NewSalesOrderNo, "Sales Document Type"::Order, "Sales Document Type From"::Order);
        //[THEN] Sales order has lookup value equal to lookup value from copied document.
        VerifySalesHeaderHasLookUpValue(DocumentNo, NewSalesOrderNo, "Sales Document Type"::Order);
    end;

    [Test]
    procedure CopySalesQuoteWithLookupValueIntoSalesQuoteWithoutLookupValue()
    var
        DocumentNo: Code[20];
        NewSalesQuoteNo: Code[20];
        LookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0004] Copy sales quote with lookup value to sales quote without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with quote order numbers
        CreateSalesSetupWithQuoteNos(SerieNumber);
        //[GIVEN] Sales & Receivable setup with return order numbers
        CreateSalesSetupWithReturnOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] Sales quote without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::Quote);
        //[GIVEN] Sales quote with lookup value.
        NewSalesQuoteNo := CreateDocumentWithLookupValue("Sales Document Type"::Quote, LookupValueCode);
        //[WHEN] Copy sales quote in new sales quote.
        CopyDocumentIntoSalesHeader(DocumentNo, NewSalesQuoteNo, "Sales Document Type"::Quote, "Sales Document Type From"::Quote);
        //[THEN] Sales quote has lookup value equal to lookup value from copied sales quote.
        VerifySalesHeaderHasLookUpValue(DocumentNo, NewSalesQuoteNo, "Sales Document Type"::Quote);
    end;

    [Test]
    procedure CopySalesInvoiceWithLookupValueIntoSalesInvoiceWithoutLookupValue()
    var
        DocumentNo: Code[20];
        NewInvoiceSaleNo: Code[20];
        LookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0005] Copy sales invoice with lookup value to sales invoice without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with invoice numbers
        CreateSalesSetupWithInvoiceNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] Sales invoice without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::Invoice);
        //[GIVEN] Sales invoice with lookup value.
        NewInvoiceSaleNo := CreateDocumentWithLookupValue("Sales Document Type"::Invoice, LookupValueCode);
        //[WHEN] Copy sales invoice in new sales invoice.
        CopyDocumentIntoSalesHeader(DocumentNo, NewInvoiceSaleNo, "Sales Document Type"::Invoice, "Sales Document Type From"::Invoice);
        //[THEN] Sales invoice has lookup value equal to lookup value from copied sales invoice.
        VerifySalesHeaderHasLookUpValue(DocumentNo, NewInvoiceSaleNo, "Sales Document Type"::Invoice);
    end;

    [Test]
    procedure CopyBlanketOrderWithLookupValueIntoBlanketOrderWithoutLookupValue()
    var
        SalesHeader: Record "Sales Header";
        DocumentNo: Code[20];
        NewBlanketOrderNo: Code[20];
        LookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0006] Copy blanket order with lookup value to blanket sales order without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithBlanketOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] Blanket order without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::"Blanket Order");
        //[GIVEN] Blanket order with lookup value.
        NewBlanketOrderNo := CreateDocumentWithLookupValue("Sales Document Type"::"Blanket Order", LookupValueCode);
        //[WHEN] Copy blanket order in new blanket order.
        CopyDocumentIntoSalesHeader(DocumentNo, NewBlanketOrderNo, "Sales Document Type"::"Blanket Order", "Sales Document Type From"::"Blanket Order");
        //[THEN] Blanket has lookup value equal to lookup value from copied blanket order.
        VerifySalesHeaderHasLookUpValue(DocumentNo, NewBlanketOrderNo, "Sales Document Type"::"Blanket Order");
    end;

    [Test]
    procedure CopyReturnOrderWithLookupValueIntoReturnOrderWithoutLookupValue()
    var
        DocumentNo: Code[20];
        NewReturnOrderNo: Code[20];
        LookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0007] Copy return order with lookup value to return order without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithReturnOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] Return order without lookup value.
        DocumentNo := CreateDocumentWithoutLookupValue("Sales Document Type"::"Return Order");
        //[GIVEN] Return order with lookup value.
        NewReturnOrderNo := CreateDocumentWithLookupValue("Sales Document Type"::"Return Order", LookupValueCode);
        //[WHEN] Copy return order in new return order.
        CopyDocumentIntoSalesHeader(DocumentNo, NewReturnOrderNo, "Sales Document Type"::"Return Order", "Sales Document Type From"::"Return Order");
        //[THEN] Return order has lookup value equal to lookup value from copied return order.
        VerifySalesHeaderHasLookUpValue(DocumentNo, NewReturnOrderNo, "Sales Document Type"::"Return Order");
    end;

    local procedure CreateDocumentWithLookupValue(DocumentType: Enum "Sales Document Type"; LookupCode: Code[20]): Code[20]
    var
        LibrarySales: Codeunit "Library - Sales";
        SalesHeader: Record "Sales Header";
    begin
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

    local procedure VerifySalesHeaderHasLookUpValue(DocumentNo: Code[20]; NewSalesHeaderNo: Code[20]; DocumentType: enum "Sales Document Type")
    var
        OldSalesHeader: Record "Sales Header";
        NewSalesHeader: Record "Sales Header";
    begin
        OldSalesHeader.Get(DocumentType, DocumentNo);
        NewSalesHeader.Get(DocumentType, NewSalesHeaderNo);
        Assert.AreEqual(OldSalesHeader."Lookup Value Code", NewSalesHeader."Lookup Value Code", NewSalesHeader.FieldCaption("Lookup Value Code"));
    end;

}