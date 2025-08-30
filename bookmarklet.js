// Bookmarklet básico para Canva (versión gratuita)
javascript:(function(){
    // Cargar el contenido HTML exportado desde Word
    var htmlContent = prompt("Pega aquí el contenido HTML exportado desde Word:");
    
    if (htmlContent) {
        // Crear un elemento temporal para parsear el HTML
        var tempDiv = document.createElement('div');
        tempDiv.innerHTML = htmlContent;
        
        // Obtener todos los elementos de texto
        var textElements = tempDiv.querySelectorAll('h1, h2, p, ul, ol');
        
        // Función para agregar texto a Canva
        function addTextToCanva(text, isHeading, isList) {
            // Hacer clic en el botón de texto de Canva
            var textButton = document.querySelector('[data-testid="element-sidebar-text-tab"]');
            if (textButton) textButton.click();
            
            // Esperar a que se carguen las opciones de texto
            setTimeout(function() {
                // Agregar un cuadro de texto
                var addTextBtn = document.querySelector('[data-testid="add-text-button"]');
                if (addTextBtn) addTextBtn.click();
                
                // Esperar a que se cree el cuadro de texto
                setTimeout(function() {
                    // Seleccionar el cuadro de texto recién creado
                    var textBox = document.querySelector('[contenteditable="true"]');
                    if (textBox) {
                        // Establecer el texto
                        textBox.textContent = text;
                        
                        // Aplicar formato según el tipo
                        if (isHeading === 1) {
                            // Formato de encabezado 1
                            var fontSizeSelect = document.querySelector('[data-testid="font-size-input"]');
                            if (fontSizeSelect) fontSizeSelect.value = 36;
                        } else if (isHeading === 2) {
                            // Formato de encabezado 2
                            var fontSizeSelect = document.querySelector('[data-testid="font-size-input"]');
                            if (fontSizeSelect) fontSizeSelect.value = 24;
                        }
                        
                        // Disparar evento de cambio
                        var event = new Event('change', { bubbles: true });
                        if (fontSizeSelect) fontSizeSelect.dispatchEvent(event);
                    }
                }, 1000);
            }, 500);
        }
        
        // Procesar cada elemento de texto
        textElements.forEach(function(element, index) {
            setTimeout(function() {
                var isHeading = 0;
                var isList = false;
                
                if (element.tagName === 'H1') isHeading = 1;
                if (element.tagName === 'H2') isHeading = 2;
                if (element.tagName === 'UL' || element.tagName === 'OL') isList = true;
                
                addTextToCanva(element.textContent, isHeading, isList);
            }, index * 3000); // Esperar 3 segundos entre cada elemento
        });
        
        // Mostrar mensaje sobre versión comercial
        setTimeout(function() {
            alert('¿Necesitas conservar listas numeradas y formato complejo? \n\nConsulta nuestra licencia comercial en https://github.com/tuusuario/WordToCanva-Extension');
        }, textElements.length * 3000 + 2000);
    }
})();
