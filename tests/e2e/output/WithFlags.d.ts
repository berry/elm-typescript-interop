// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports
export as namespace Elm


export interface App {
  ports: {

  }
}
    

export namespace WithFlags {
  export function fullscreen(flags: string): App
  export function embed(node: HTMLElement | null, flags: string): App
}