# Proxmox Snapshot Deletion Script

Este script está diseñado para eliminar snapshots de máquinas virtuales (VM) en Proxmox.

## Requisitos

- `pvesh`: Herramienta de línea de comandos de Proxmox.

## Uso

1. **Descarga o clona este repositorio:**

   ```bash
   git clone https://github.com/tu-usuario/proxmox-snapshot-deletion.git
   cd proxmox-snapshot-deletion


2. **Asegúrate de que pvesh esté instalado y configurado en tu sistema**

3. **Haz el script ejecutable**

   chmod +x delete_snapshot_by_vm_id_and_name_and_host.sh

4. **Ejecuta el scrip**

   ./delete_snapshot_by_vm_id_and_name_and_host.sh

El script te pedirá:

El ID de la VM.
El nombre del snapshot que deseas eliminar.
El nombre del nodo donde se encuentra la VM.

## Notas
Asegúrate de tener los permisos necesarios para eliminar snapshots.
Este script no realiza comprobaciones adicionales sobre el estado de la VM o el snapshot más allá de verificar su existencia.

## Contribuciones
Las contribuciones son bienvenidas. Si tienes sugerencias o encuentras errores, por favor abre un issue o un pull request en el repositorio.
