codeunit 80023 "Lookup value Rest. arch. sales"
{
    //[FEATURE] LookupValue UT Restore archived sales
    Subtype = Test;
    TestPermissions = Disabled;

    var
        Assert: Codeunit "Library Assert";

    [HandlerFunctions('ConfirmArchiveNo,ConfirmArchived')]
    [Test]
    procedure RestoreArchivedSalesOrderWithLookupValueToSalesOrderWithLookupValue()
    var
        SalesHeader: Record "Sales Header";
        LookupValueCode: Code[20];
        NewLookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0008] Restore archived sales order with lookup value to sales order with new lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] New lookup value
        NewLookupValueCode := CreateLookupValueCode();
        //[GIVEN] Sales order with lookup value.
        CreateDocumentWithLookupValue(SalesHeader, "Sales Document Type"::Order, LookupValueCode);
        //[GIVEN] Archived sales order with lookup value.
        CreateArchivedDocumentFromSalesDocument(SalesHeader."No.", "Sales Document Type"::Order);
        //[GIVEN] Change Lookup value on sales order to new lookup value
        ChangeLookupCodeForSalesDocument(SalesHeader."No.", NewLookupValueCode, "Sales Document Type"::Order);

        //[WHEN] Restore archives sales order.
        RestoreArchivedDocument(SalesHeader."No.", "Sales Document Type"::Order);

        //[THEN] Sales order has lookup value equal to lookup value from the archived sales order.
        VerifySalesHeaderLookupValueEqualsToArchivedLookupValue(SalesHeader."Lookup Value Code", LookupValueCode, "Sales Document Type"::Order);
    end;

    [HandlerFunctions('ConfirmArchiveNo,ConfirmArchived')]
    [Test]
    procedure RestoreArchivedSalesOrderWithoutLookupValueToSalesOrderWithLookupValue()
    var
        SalesHeader: Record "Sales Header";
        ArchivedSalesNo: Code[20];
        ChangedLookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0009] Restore archived sales order without lookup value to sales order with lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        ChangedLookupValueCode := CreateLookupValueCode();
        //[GIVEN] Sales order without lookup value.
        CreateDocumentWithoutLookupValue(SalesHeader, "Sales Document Type"::Order);
        //[GIVEN] Archived sales order with lookup value.
        CreateArchivedDocumentFromSalesDocument(SalesHeader."No.", "Sales Document Type"::Order);
        //[GIVEN] Change Lookup value on sales order to new lookup value
        ChangeLookupCodeForSalesDocument(SalesHeader."No.", ChangedLookupValueCode, "Sales Document Type"::Order);

        //[WHEN] Restore archives sales order.
        RestoreArchivedDocument(SalesHeader."No.", "Sales Document Type"::Order);

        //[THEN] Sales order has lookup value equal to lookup value from the archived sales order.
        VerifySalesHeaderLookupValueEqualsToArchivedLookupValue(SalesHeader."Lookup Value Code", '', "Sales Document Type"::Order);
    end;

    [HandlerFunctions('ConfirmArchiveNo,ConfirmArchived')]
    [Test]
    procedure RestoreArchivedSalesOrderWithLookupValueToSalesOrderWithoutLookupValue()
    var
        SalesHeader: Record "Sales Header";
        ArchivedSalesNo: Code[20];
        LookupValueCode: Code[20];
        NewLookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0010] Restore archived sales order with lookup value to sales order without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with order numbers
        CreateSalesSetupWithOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] NewLookUpValue
        NewLookupValueCode := '';
        //[GIVEN] Sales order with lookup value.
        CreateDocumentWithoutLookupValue(SalesHeader, "Sales Document Type"::Order);
        //[GIVEN] Archived sales order with lookup value.
        CreateArchivedDocumentFromSalesDocument(SalesHeader."No.", "Sales Document Type"::Order);
        //[GIVEN] Change Lookup value on sales order to new lookup value
        ChangeLookupCodeForSalesDocument(SalesHeader."No.", NewLookupValueCode, "Sales Document Type"::Order);

        //[WHEN] Restore archives sales order.
        RestoreArchivedDocument(SalesHeader."No.", "Sales Document Type"::Order);

        //[THEN] Sales order has lookup value equal to lookup value from the archived sales order.
        VerifySalesHeaderLookupValueEqualsToArchivedLookupValue(SalesHeader."Lookup Value Code", NewLookupValueCode, "Sales Document Type"::Order);
    end;

    [HandlerFunctions('ConfirmArchiveNo,ConfirmArchived')]
    [Test]
    procedure RestoreArchivedSalesQuoteWithLookupValueToSalesQuoteWithoutLookupValue()
    var
        SalesHeader: Record "Sales Header";
        ArchivedSalesNo: Code[20];
        LookupValueCode: Code[20];
        NewLookupCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0011] Restore archived sales quote with lookup value to sales quote without lookup value.
        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with Quote numbers
        CreateSalesSetupWithQuoteNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] New lookup value
        NewLookupCode := '';
        //[GIVEN] Sales quote with lookup value.
        CreateDocumentWithoutLookupValue(SalesHeader, "Sales Document Type"::Quote);
        //[GIVEN] Archived sales quote with lookup value.
        CreateArchivedDocumentFromSalesDocument(SalesHeader."No.", "Sales Document Type"::Quote);
        //[GIVEN] Change Lookup value on sales quote to new lookup value
        ChangeLookupCodeForSalesDocument(SalesHeader."No.", NewLookupCode, "Sales Document Type"::Quote);

        //[WHEN] Restore archives sales quote.
        RestoreArchivedDocument(SalesHeader."No.", "Sales Document Type"::Quote);

        //[THEN] Sales quote has lookup value equal to lookup value from the archived sales quote.
        VerifySalesHeaderLookupValueEqualsToArchivedLookupValue(SalesHeader."Lookup Value Code", NewLookupCode, "Sales Document Type"::Quote);
    end;

    [HandlerFunctions('ConfirmArchiveNo,ConfirmArchived')]
    [Test]
    procedure RestoreArchivedSalesInvoiceWithLookupValueToSalesInvoiceWithoutLookupValue()
    var
        SalesHeader: Record "Sales Header";
        ArchivedSalesNo: Code[20];
        LookupValueCode: Code[20];
        NewLookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0012] Restore archived sales invoice with lookup value to sales invoice without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with blanket order numbers
        CreateSalesSetupWithInvoiceNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        NewLookupValueCode := '';
        //[GIVEN] Sales invoice with lookup value.
        CreateDocumentWithoutLookupValue(SalesHeader, "Sales Document Type"::Invoice);
        //[GIVEN] Archived sales invoice with lookup value.
        CreateArchivedDocumentFromSalesDocument(SalesHeader."No.", "Sales Document Type"::Invoice);
        //[GIVEN] Change Lookup value on sales invoice to new lookup value
        ChangeLookupCodeForSalesDocument(SalesHeader."No.", NewLookupValueCode, "Sales Document Type"::Invoice);

        //[WHEN] Restore archives sales invoice.
        RestoreArchivedDocument(SalesHeader."No.", "Sales Document Type"::Invoice);

        //[THEN] Sales invoice has lookup value equal to lookup value from the archived sales invoice.
        VerifySalesHeaderLookupValueEqualsToArchivedLookupValue(SalesHeader."Lookup Value Code", NewLookupValueCode, "Sales Document Type"::Invoice);
    end;

    [HandlerFunctions('ConfirmArchiveNo,ConfirmArchived')]
    [Test]
    procedure RestoreArchivedDocumentWithLookupValueToBlanketOrderWithoutLookupValue()
    var
        SalesHeader: Record "Sales Header";
        ArchivedSalesNo: Code[20];
        LookupValueCode: Code[20];
        NewLookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0013] Restore archived Blanket order with lookup value to blanket order without lookup value.

        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with blanket order numbers
        CreateSalesSetupWithBlanketOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] New Lookup Value
        NewLookupValueCode := '';
        //[GIVEN] Blanket order with lookup value.
        CreateDocumentWithoutLookupValue(SalesHeader, "Sales Document Type"::"Blanket Order");
        //[GIVEN] Archived Blanket order with lookup value.
        CreateArchivedDocumentFromSalesDocument(SalesHeader."No.", "Sales Document Type"::"Blanket Order");
        //[GIVEN] Change Lookup value on Blanket order to new lookup value
        ChangeLookupCodeForSalesDocument(SalesHeader."No.", NewLookupValueCode, "Sales Document Type"::"Blanket Order");

        //[WHEN] Restore archives Blanket order.
        RestoreArchivedDocument(SalesHeader."No.", "Sales Document Type"::"Blanket Order");

        //[THEN] Blanket order has lookup value equal to lookup value from the archived Blanket order.
        VerifySalesHeaderLookupValueEqualsToArchivedLookupValue(SalesHeader."Lookup Value Code", NewLookupValueCode, "Sales Document Type"::"Blanket Order");
    end;

    [HandlerFunctions('ConfirmArchiveNo,ConfirmArchived')]
    [Test]
    procedure RestoreArchivedReturnOrderWithLookupValueToReturnOrderWithoutLookupValue()
    var
        SalesHeader: Record "Sales Header";
        ArchivedSalesNo: Code[20];
        LookupValueCode: Code[20];
        NewLookupValueCode: Code[20];
        SerieNumber: Code[20];
    begin
        //[SCENARIO #0014] Restore archived return order with lookup value to return order without lookup value.
        //[GIVEN] Number of series
        SerieNumber := CreateNoSeries();
        //[GIVEN] Sales & Receivable setup with return order numbers
        CreateSalesSetupWithReturnOrderNos(SerieNumber);
        //[GIVEN] Lookup Value
        LookupValueCode := CreateLookupValueCode();
        //[GIVEN] New Lookup value
        NewLookupValueCode := '';
        //[GIVEN] return order with lookup value.
        CreateDocumentWithoutLookupValue(SalesHeader, "Sales Document Type"::"Return Order");
        //[GIVEN] Archived return order with lookup value.
        CreateArchivedDocumentFromSalesDocument(SalesHeader."No.", "Sales Document Type"::"Return Order");
        //[GIVEN] Change Lookup value on return order to new lookup value
        ChangeLookupCodeForSalesDocument(SalesHeader."No.", NewLookupValueCode, "Sales Document Type"::"Return Order");

        //[WHEN] Restore archives return order.
        RestoreArchivedDocument(SalesHeader."No.", "Sales Document Type"::"Return Order");

        //[THEN] return order has lookup value equal to lookup value from the archived return order.
        VerifySalesHeaderLookupValueEqualsToArchivedLookupValue(SalesHeader."Lookup Value Code", NewLookupValueCode, "Sales Document Type"::"Return Order");
    end;

    local procedure VerifySalesHeaderLookupValueEqualsToArchivedLookupValue(ActualLookupValue: Code[20]; ExpectedLookupValue: Code[20]; DocumentType: Enum "Sales Document Type")
    var
        SalesHeader: Record "Sales Header";
    begin
        Assert.AreEqual(ExpectedLookupValue, ActualLookupValue, SalesHeader.FieldCaption("Lookup Value Code"));
    end;

    local procedure RestoreArchivedDocument(SalesHeaderNo: Code[20]; DocumentType: Enum "Sales Document Type")
    var
        ArchiveMgt: Codeunit ArchiveManagement;
        ArchivedDocument: Record "Sales Header Archive";
    begin
        ArchivedDocument.Get(DocumentType, SalesHeaderNo, 1, 1);
        ArchiveMgt.RestoreSalesDocument(ArchivedDocument);
    end;

    local procedure ChangeLookupCodeForSalesDocument(SalesHeaderNo: Code[20]; NewLookupCode: Code[20]; DocumentType: Enum "Sales Document Type")
    var
        SalesOrder: Record "Sales Header";
    begin
        SalesOrder.Get(DocumentType, SalesHeaderNo);
        SalesOrder."Lookup Value Code" := NewLookupCode;
        SalesOrder.Modify(true);
    end;

    local procedure CreateLookupValueCode(): Code[10]
    var
        LibraryLookupValue: Codeunit "Library - Lookup Value";
    begin
        exit(LibraryLookupValue.CreateLookupValueCode())
    end;

    local procedure CreateArchivedDocumentFromSalesDocument(SalesOrderNo: Code[20]; DocumentType: Enum "Sales Document Type")
    var
        ArchiveMgt: Codeunit ArchiveManagement;
        SalesOrder: Record "Sales Header";
    begin
        SalesOrder.Get(DocumentType, SalesOrderNo);
        ArchiveMgt.ArchiveSalesDocument(SalesOrder);
    end;

    local procedure CreateDocumentWithoutLookupValue(var SalesHeader: Record "Sales Header"; DocumentType: Enum "Sales Document Type"): Code[20]
    var
        LibrarySales: Codeunit "Library - Sales";
    begin
        LibrarySales.CreateSalesHeader(SalesHeader, DocumentType, '');

        exit(SalesHeader."No.");
    end;

    local procedure CreateDocumentWithLookupValue(var SalesHeader: Record "Sales Header"; DocumentType: Enum "Sales Document Type"; LookupCode: Code[20]): Code[20]
    var
        LibrarySales: Codeunit "Library - Sales";
    begin
        LibrarySales.CreateSalesHeader(SalesHeader, DocumentType, '');

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

    [ConfirmHandler]
    procedure ConfirmArchiveNo(Question: Text[1024]; var Reply: Boolean)
    begin
    end;

    [MessageHandler]
    procedure ConfirmArchived(Question: Text[1024])
    begin
    end;
}