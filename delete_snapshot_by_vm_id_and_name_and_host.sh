#!/bin/bash

# Solicita el ID de la VM al usuario
read -p "Ingrese el ID de la VM: " VM_ID

# Solicita el nombre del snapshot al usuario
read -p "Ingrese el nombre del snapshot: " SNAPSHOT_NAME

# Solicita el nodo donde se encuentra la VM
read -p "Ingrese el nombre del nodo donde se encuentra la VM: " NODE

# Verifica si la VM existe en el nodo especificado
echo "Verificando existencia de VM $VM_ID en nodo $NODE..."

# Obtén la lista de VMs en el nodo especificado
VM_LIST=$(pvesh get /nodes/$NODE/qemu 2>&1)

# Verifica si hubo un error en la ejecución de pvesh
if [ $? -ne 0 ]; then
    echo "Error al obtener la lista de VMs en el nodo $NODE. Salida del comando: $VM_LIST"
    exit 1
fi

# Depuración: Imprime la lista de VMs
echo "Lista de VMs en el nodo $NODE:"
echo "$VM_LIST"

# Verifica si la VM existe en la lista usando grep
if echo "$VM_LIST" | grep -q " $VM_ID "; then
    echo "VM $VM_ID encontrada en nodo $NODE"

    # Verifica si el snapshot existe para la VM en el nodo actual
    SNAPSHOTS=$(pvesh get /nodes/$NODE/qemu/$VM_ID/snapshot 2>&1)

    if [ $? -ne 0 ]; then
        echo "Error obteniendo snapshots para VM $VM_ID en nodo $NODE. Salida del comando: $SNAPSHOTS"
        exit 1
    fi

    # Depuración: Imprime la lista de snapshots
    echo "Lista de snapshots para VM $VM_ID en el nodo $NODE:"
    echo "$SNAPSHOTS"

    # Verifica si el snapshot existe usando grep
    if echo "$SNAPSHOTS" | grep -q " $SNAPSHOT_NAME "; then
        # Elimina el snapshot si existe
        echo "Eliminando snapshot $SNAPSHOT_NAME de VM $VM_ID en nodo $NODE"
        DELETE_RESULT=$(pvesh delete /nodes/$NODE/qemu/$VM_ID/snapshot/$SNAPSHOT_NAME 2>&1)

        if [ $? -eq 0 ]; then
            echo "Snapshot $SNAPSHOT_NAME eliminado exitosamente en nodo $NODE."
        else
            echo "Error al eliminar el snapshot $SNAPSHOT_NAME en nodo $NODE. Salida del comando: $DELETE_RESULT"
        fi
    else
        echo "Snapshot $SNAPSHOT_NAME no encontrado para VM $VM_ID en nodo $NODE."
    fi
else
    echo "La VM con ID $VM_ID no existe en el nodo $NODE."
fi
