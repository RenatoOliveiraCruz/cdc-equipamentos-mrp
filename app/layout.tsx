import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = { title: 'CDC MRP | Gestão Integrada', description: 'Protótipo inicial de MRP integrado para CDC Equipamentos' };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="pt-BR"><body>{children}</body></html>; }
