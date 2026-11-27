# CDC MRP Starter — v0.1

Protótipo funcional de MRP integrado para validação inicial dos fluxos da CDC Equipamentos. Aplicação Next.js + TypeScript, pronta para deploy na Vercel e persistência compartilhada via Supabase/PostgreSQL.

## Módulos incluídos
- Painel geral com visão por setor e cálculo demonstrativo de necessidade de materiais.
- Vendas: cliente, SKU, quantidade, valor e observações.
- Produtos/Engenharia: SKU, unidade, lead time e BOM multinível simples (componentes em lista).
- Estoque: saldo físico, reservado, localização e unidade.
- Compras: fornecedor, material, quantidade, previsão e custo.
- Produção/PCP: produto, pedido relacionado, quantidade, centro de trabalho e responsável.
- Transporte/Expedição: cliente, pedido, transportadora, rastreio e previsão.
- Busca e atualização de status.

## Rodar localmente
1. Instale Node.js 20+.
2. Na pasta do projeto: `npm install`.
3. Copie `.env.example` para `.env.local` e preencha as variáveis do Supabase (opcional para modo demonstração).
4. `npm run dev` e abra http://localhost:3000.

Sem Supabase, o protótipo usa localStorage do navegador: é útil para demonstração individual, mas os dados não são compartilhados entre computadores e podem ser apagados pelo navegador.

## Configurar banco Supabase
1. Crie um projeto PostgreSQL no Supabase.
2. Abra SQL Editor e execute `supabase/schema.sql`.
3. Em Project Settings → API, copie Project URL e anon/public key.
4. Preencha `.env.local`:

```
NEXT_PUBLIC_SUPABASE_URL=https://SEU-PROJETO.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=SUA_CHAVE_ANON
```

5. Reinicie o servidor. O cabeçalho deve indicar “Banco conectado”.

## Publicar na Vercel
1. Suba o conteúdo deste projeto para um repositório privado no GitHub.
2. Na Vercel, importe o repositório.
3. Configure as duas variáveis de ambiente do Supabase também na Vercel.
4. Deploy.

## Como testar o cálculo MRP
1. Cadastre em Produtos um item acabado, por exemplo `DEC-001`.
2. No campo BOM, use `MAT-001:Chapa de aço:2;PAR-001:Parafuso:8`.
3. Cadastre em Estoque os materiais `MAT-001` e `PAR-001`, com saldo físico e reservado.
4. Cadastre em Vendas um pedido com SKU `DEC-001` e quantidade, por exemplo 3.
5. Volte ao Painel geral: o MRP calcula necessidade bruta dos componentes e subtrai saldo disponível.

## Limitações importantes da v0.1
- O MRP é demonstrativo: ainda não faz explosão recursiva de BOM, planejamento por período, estoque de segurança, perdas/sucata, múltiplos depósitos com transferência, reserva automática, capacidade finita, sequenciamento, lead time offset, lote econômico/mínimo, ordens planejadas, custos reais ou integração fiscal/logística.
- Não há login, perfis, trilha de auditoria ou segregação por empresa/filial.
- O SQL fornecido libera acesso amplo para facilitar teste. **Não use com dados reais nem publique para a equipe antes de implementar autenticação, RLS por usuário/perfil, políticas restritivas, backup e revisão de segurança.** A chave anon não deve ser confundida com service role; nunca coloque service role no frontend.
- O modelo de dados genérico em `records` é intencionalmente simples para validar processos. Antes de produção, normalizar entidades, relacionamentos, unidades de medida, revisões de engenharia, OPs/roteiros, reservas, recebimentos e movimentações.

## Próxima etapa recomendada
Mapear com o proprietário e responsáveis de cada setor o fluxo real: pedido → análise técnica → engenharia/BOM → MRP → compras → recebimento → OP → apontamento → inspeção → expedição → entrega. Só depois fechar regras e permissões para a v1.
