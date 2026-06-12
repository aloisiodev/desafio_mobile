# bycoders

![Swift](https://img.shields.io/badge/Swift-6.0-orange?logo=swift)
![Platform](https://img.shields.io/badge/platform-iOS%2017%2B-lightgrey?logo=apple)
![Xcode](https://img.shields.io/badge/Xcode-16%2B-blue?logo=xcode)
![Firebase](https://img.shields.io/badge/Firebase-12.14-yellow?logo=firebase)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen)

Implementação do desafio mobile da bycoders por [Aloisio Mello](https://github.com/aloisiomello). O descritivo original do desafio está em [desafio.md](desafio.md).

# Implementação

A solução foi desenvolvida em Swift com SwiftUI, seguindo o padrão MVVM. As dependências são gerenciadas via Swift Package Manager e o Firebase é utilizado para autenticação, Analytics e Crashlytics. A persistência local usa CoreData, que é o framework nativo da Apple para esse fim. O desafio sugere WatermelonDB, mas como ele é voltado para React Native, optei pelo CoreData por ser a solução idiomática no ecossistema Swift e não adicionar dependências externas desnecessárias.

## Pré-requisitos

Xcode 16 ou superior e iOS 17 como deployment target. Não há dependências externas além das gerenciadas pelo SPM, que o Xcode resolve automaticamente na primeira abertura do projeto.

## Configuração do Firebase

O projeto depende de um arquivo `GoogleService-Info.plist` que não está versionado por conter chaves de API. Para configurar:

1. Acesse o [Firebase Console](https://console.firebase.google.com) e crie um projeto (ou use um existente).
2. Adicione um app iOS com o bundle ID `com.bycoders.bycoders`.
3. Baixe o `GoogleService-Info.plist` gerado e adicione-o dentro da pasta `bycoders/` no Xcode, certificando-se de que o target `bycoders` está marcado no diálogo de adição.
4. No Firebase Console, ative o método de autenticação por e-mail e senha em Authentication > Sign-in method.
5. Crie um usuário de teste em Authentication > Users para usar no login.

## Rodando o projeto

Abra `bycoders.xcodeproj` no Xcode. O SPM vai resolver as dependências do Firebase automaticamente, o que pode levar alguns minutos na primeira vez. Selecione um simulador com iOS 17 ou superior e rode com Cmd+R.

O mapa requer permissão de localização. No simulador, é possível simular uma localização em Features > Location.

## Rodando os testes

Os testes unitários ficam no target `bycodersTests` e os de UI no `bycodersUITests`. Para rodar todos de uma vez, use Cmd+U no Xcode ou selecione Product > Test.

Os testes unitários não dependem de Firebase nem de rede, pois usam mocks para `AuthServicing` e `LocalSessionRepositoring`. Os testes de UI sobem o app completo no simulador, então o `GoogleService-Info.plist` precisa estar configurado.

Os testes de UI usam launch arguments para controlar o estado do app durante a execução. `--skip-auth` faz o app abrir direto na Home sem passar pelo login, `--reset-session` ignora qualquer sessão salva e força a tela de login, e `--simulate-location-denied` simula um dispositivo com permissão de localização negada. Esses argumentos são configurados nos schemes de teste e não requerem nenhuma alteração manual.

## Observações

O evento de Analytics `map_rendered` é disparado apenas uma vez por sessão, na primeira vez que a localização é recebida. Essa é uma decisão intencional para não inflar os dados com atualizações de coordenada subsequentes, que acontecem continuamente enquanto o app está em uso.

O app restaura a sessão automaticamente na abertura caso o usuário já esteja autenticado no Firebase, abrindo direto na tela Home. Para testar o fluxo de login do zero, basta usar o botão de logout na Home, que encerra a sessão tanto localmente quanto no Firebase.
