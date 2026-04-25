# Referência Técnica: Sistema de Outline (Bordas) - FiveM

Este repositório serve como um **guia de referência e exemplo técnico** para desenvolvedores que desejam implementar sistemas de contorno (bordas) em entidades no FiveM utilizando as funções nativas de renderização do GTA V.

> [!NOTE]
> Este não é um script "plug-and-play" finalizado, mas sim uma base didática para que outros desenvolvedores possam entender a lógica e criar seus próprios sistemas personalizados.

## 🧠 Lógica de Implementação

O sistema de Outline funciona através de um loop de renderização que monitora entidades específicas e aplica o efeito visual. A lógica fundamental explicada aqui é:

1.  **Configuração Global**: Definir uma única vez (ou quando mudar) como a linha deve parecer (Cor, Shader e Técnica).
2.  **Loop de Monitoramento**: Verificar constantemente quais jogadores próximos atendem aos critérios (distância, vida, aliado/inimigo).
3.  **Ativação de Estado**: Ligar ou desligar o contorno na entidade conforme a necessidade.

## 🛠️ Detalhes Técnicos (Referência)

### Natives Principais
- `SetEntityDrawOutline(entity, toggle)`: O comando principal que ativa/desativa a borda.
- `SetEntityDrawOutlineColor(r, g, b, a)`: Define a estética visual (RGBA).
- `SetEntityDrawOutlineShader(shader)`: Define o estilo do brilho (comumente `1`).
- `SetEntityDrawOutlineRenderTechnique(technique)`: Define a técnica (ex: `"waterreflection"` para maior nitidez).

### Trecho de Código Comentado (`client-side/core.lua`)

```lua
-- Exemplo de Loop de Renderização
Citizen.CreateThread(function()
    setupOutline() -- Configura cores e shaders uma única vez

    while true do
        -- Lógica de busca de jogadores...
        
        -- Aplicação condicional
        if shouldShow then
            SetEntityDrawOutline(targetPed, true)
        else
            SetEntityDrawOutline(targetPed, false)
        end

        Citizen.Wait(500) -- Intervalo para não pesar no processamento
    end
end)
```

## 🚀 Como usar como referência

1. **Estude o Loop**: Veja como o script gerencia a ativação/desativação para não chamar a native `true` a cada frame sem necessidade.
2. **Adapte a Lógica de Aliança**: O script possui uma função `isAlly` de exemplo que pode ser substituída por checagens de `StateBags`, `Teams` ou `Factions` do seu próprio framework.
3. **Experimente Técnicas**: Teste diferentes strings em `SetEntityDrawOutlineRenderTechnique` para ver variações visuais.

## 📂 Estrutura do Exemplo
- `client-side/core.lua`: Contém toda a lógica de renderização comentada.
- `server-side/core.lua`: Estrutura básica para quem deseja expandir com sincronização servidor-cliente.
- `fxmanifest.lua`: Configuração básica do recurso.

---
*Este material foi criado com fins educativos para a comunidade de desenvolvedores FiveM.*
