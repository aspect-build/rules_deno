export function canUseColor(): boolean {
  return !Deno.noColor;
}
