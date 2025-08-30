Sub ExportToCanva()
    ' Macro para Word que exporta el contenido con formato básico
    Dim doc As Document
    Set doc = ActiveDocument
    
    Dim exportFile As String
    exportFile = Environ("USERPROFILE") & "\Desktop\CanvaExport.html"
    
    ' Crear archivo HTML con formato básico
    Open exportFile For Output As #1
    
    Print #1, "<!DOCTYPE html>"
    Print #1, "<html>"
    Print #1, "<head>"
    Print #1, "<meta charset='UTF-8'>"
    Print #1, "<title>Documento exportado a Canva</title>"
    Print #1, "<style>"
    Print #1, "body { font-family: Arial, sans-serif; line-height: 1.6; }"
    Print #1, "h1 { font-size: 24px; font-weight: bold; margin-bottom: 16px; }"
    Print #1, "h2 { font-size: 20px; font-weight: bold; margin-bottom: 14px; }"
    Print #1, "p { margin: 12px 0; }"
    Print #1, ".bold { font-weight: bold; }"
    Print #1, ".italic { font-style: italic; }"
    Print #1, ".underline { text-decoration: underline; }"
    Print #1, "ul, ol { margin: 12px 0; padding-left: 24px; }"
    Print #1, "li { margin: 4px 0; }"
    Print #1, "</style>"
    Print #1, "</head>"
    Print #1, "<body>"
    
    ' Recorrer todos los párrafos del documento
    Dim para As Paragraph
    For Each para In doc.Paragraphs
        If para.Range.Text <> vbCr Then ' Ignorar párrafos vacíos
            Dim htmlLine As String
            htmlLine = ProcessParagraph(para)
            Print #1, htmlLine
        End If
    Next para
    
    Print #1, "</body>"
    Print #1, "</html>"
    
    Close #1
    
    MsgBox "Documento exportado como: " & exportFile, vbInformation, "Exportación completada"
End Sub

Function ProcessParagraph(para As Paragraph) As String
    Dim result As String
    Dim rng As Range
    Set rng = para.Range
    
    ' Determinar el tipo de párrafo
    Select Case para.Style
        Case "Heading 1", "Título 1"
            result = "<h1>" & CleanText(rng.Text) & "</h1>"
        Case "Heading 2", "Título 2"
            result = "<h2>" & CleanText(rng.Text) & "</h2>"
        Case Else
            ' Verificar si es una lista
            If para.Range.ListFormat.ListType <> wdListNoNumbering Then
                result = ProcessList(para)
            Else
                ' Procesar formato a nivel de caracteres
                result = "<p>"
                Dim i As Integer
                For i = 1 To rng.Characters.Count
                    Dim charRng As Range
                    Set charRng = rng.Characters(i)
                    
                    Dim charText As String
                    charText = CleanText(charRng.Text)
                    
                    If charText <> "" Then
                        Dim formattedText As String
                        formattedText = charText
                        
                        ' Aplicar formatos
                        If charRng.Bold Then
                            formattedText = "<span class='bold'>" & formattedText & "</span>"
                        End If
                        
                        If charRng.Italic Then
                            formattedText = "<span class='italic'>" & formattedText & "</span>"
                        End If
                        
                        If charRng.Underline <> wdUnderlineNone Then
                            formattedText = "<span class='underline'>" & formattedText & "</span>"
                        End If
                        
                        result = result & formattedText
                    End If
                Next i
                
                result = result & "</p>"
            End If
    End Select
    
    ProcessParagraph = result
End Function

Function ProcessList(para As Paragraph) As String
    Dim result As String
    Dim rng As Range
    Set rng = para.Range
    
    ' Determinar tipo de lista
    If para.Range.ListFormat.ListType = wdListBullet Then
        result = "<ul><li>"
    Else
        result = "<ol><li>"
    End If
    
    ' Procesar contenido de la lista
    Dim i As Integer
    For i = 1 To rng.Characters.Count
        Dim charRng As Range
        Set charRng = rng.Characters(i)
        
        Dim charText As String
        charText = CleanText(charRng.Text)
        
        If charText <> "" Then
            Dim formattedText As String
            formattedText = charText
            
            ' Aplicar formatos (solo para versión comercial)
            formattedText = ApplyBasicFormatting(charRng, formattedText)
            
            result = result & formattedText
        End If
    Next i
    
    result = result & "</li></ul>" ' Las listas completas se procesan en la versión comercial
    
    ProcessList = result
End Function

Function ApplyBasicFormatting(charRng As Range, text As String) As String
    ' Solo aplica formato básico (versión gratuita)
    Dim result As String
    result = text
    
    If charRng.Bold Then
        result = "<strong>" & result & "</strong>"
    End If
    
    If charRng.Italic Then
        result = "<em>" & result & "</em>"
    End If
    
    ApplyBasicFormatting = result
End Function

Function CleanText(text As String) As String
    ' Limpiar caracteres no deseados
    CleanText = Replace(text, Chr(13), "") ' Eliminar retornos de carro
    CleanText = Replace(CleanText, Chr(7), "") ' Eliminar marcas
    CleanText = Replace(CleanText, Chr(11), "") ' Eliminar tabulaciones verticales
    CleanText = Replace(CleanText, Chr(9), "    ") ' Reemplazar tabs con espacios
End Function
